import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/Installments.dart';
import 'package:gold247/models/Plan_Subscription.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:sizer/sizer.dart';

class BuyGold extends StatefulWidget {
  const BuyGold({Key key}) : super(key: key);

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<BuyGold> {
  bool watchlist = false;
  final valueController = TextEditingController();
  final amountController = TextEditingController();

  final sellValueController = TextEditingController();
  final sellAmountController = TextEditingController();

  int sellprice;
  List portfolioItems;
  buysellprice data;
  bool message;
  double walletbalace = 0.0;
  void getWalletBalanced() async {
    var request = http.Request('GET',
        Uri.parse('https://goldv2.herokuapp.com/api/wallet/${Userdata.sId}'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      walletbalace = double.parse(det['data']['gold'].toString());
    } else {
      print(response.reasonPhrase);
    }
  }

  addtowallet(String payId) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/wallet/add/${Userdata.sId}'));

    final body = {
      "gold": '${valueController.text}',
      "transaction": {
        "paymentId": '$payId',
        "amount": '${amountController.text}',
        "status": "Credited"
      }
    };
    request.headers.addAll(headers);
    request.body = jsonEncode(body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);

      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: scaffoldBgColor,
                title: Center(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      size: 30.0,
                      color: scaffoldBgColor,
                    ),
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Center(
                          child: Text(
                        "REQUEST PLACED",
                        style: black16BoldTextStyle,
                      )),
                      Center(
                          child: Text(
                        'SUCCESS',
                        style: black14MediumTextStyle,
                      )),
                      heightSpace,
                      Center(
                        child: Container(
                          color: whiteColor,
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(payId),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(new ClipboardData(text: payId))
                              .then((_) {
                            final snackBar =
                                SnackBar(content: Text('PaymentId Copied!'));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                        child: Center(
                            child: Text(
                          'Click to Copy',
                          style: black14MediumTextStyle,
                        )),
                      ),
                      heightSpace,
                    ],
                  ),
                ),
              ));
    } else {
      print(response.reasonPhrase);
    }
    return message;
  }

  Future fetchData() async {
    var request = http.Request('GET',
        Uri.parse('https://goldv2.herokuapp.com/api/buy-sell-price/letest'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      data = buysellprice.fromJson(det['data']);
    } else {
      print(response.reasonPhrase);
    }
    return data;
  }

  String InstallID;
  String SubscribeID;
  DataIN info;
  Installment Instas;

  Future Instalments() async {
    var uuid = Uuid().v1();
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/installment/create/${Userdata.sId}'));
    request.bodyFields = {
      'paymentId': uuid,
      'amount': amountController.text,
      "status": "Plan Initiated",
      "instantGoldApplied": "false",
      "mode": "COD",
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);
      Instas = Installment.fromJson(s);

      info = DataIN.fromJson(s['data']);
      InstallID = info.sId;
    } else {
      print(response.reasonPhrase);
    }
    return Instas;
  }

  DataS datas;
  PlanSubscriptions pSubs;

  Razorpay _razorpay;
  String val = "0";
  final Rkey = 'rzp_test_wVVGuz2rxyrfFd';
  void openCheckout() async {
    var options = {
      'key': Rkey,
      'amount': double.parse(amountController.text) * 100.0,
      'name': "Instant buy gold",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': Userdata.mobile, 'email': Userdata.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<bool> init;
  Future<bool> initialise() async {
    await fetchData();
    await getWalletBalanced();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(response.paymentId);
    await addtowallet(response.paymentId.toString());
  }

  // Fluttertoast.showToast(
  //     msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);

  _handlePaymentError(PaymentFailureResponse response) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: scaffoldBgColor,
              title: Center(
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.sms_failed_rounded,
                    size: 30.0,
                    color: scaffoldBgColor,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Center(
                        child: Text(
                      "REQUEST FAILED",
                      style: black16BoldTextStyle,
                    )),
                    Center(
                        child: Text(
                      'FAILED',
                      style: black14MediumTextStyle,
                    )),
                    heightSpace,
                  ],
                ),
              ),
            ));
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: init,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
              child: Scaffold(
                  backgroundColor: scaffoldBgColor,
                  body: Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ))),
            );
          } else {
            if (snapshot.hasData) {
              return SafeArea(
                  child: Scaffold(
                backgroundColor: scaffoldBgColor,
                bottomNavigationBar: Material(
                  elevation: 2.0,
                  child: Container(
                    height: 8.h,
                    width: width,
                    color: primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            buyByWeight(double.parse(data.buy.toString()));
                          },
                          child: Container(
                            height: 4.h,
                            width: (width - 1.0) / 2,
                            alignment: Alignment.center,
                            child: Text(
                              'BUY BY WEIGHT'.toUpperCase(),
                              style: white16BoldTextStyle,
                            ),
                          ),
                        ),
                        Container(
                          height: 4.h,
                          width: 1.0,
                          color: whiteColor.withOpacity(0.5),
                        ),
                        InkWell(
                          onTap: () {
                            buyByValue(double.parse(data.buy.toString()));
                          },
                          child: Container(
                            height: 4.h,
                            width: (width - 1.0) / 2,
                            alignment: Alignment.center,
                            child: Text(
                              'Buy BY VALUE'.toUpperCase(),
                              style: white16BoldTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: SafeArea(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      currencyPriceChart(data.buy),
                      aboutPortfolio(),
                    ],
                  ),
                ),
              ));
            } else {
              return Text("No data found");
            }
          }
        });
  }

  currencyPriceChart(int bp) {
    return Container(
      color: scaffoldBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                    ),
                    widthSpace,
                    Text(
                      'BUY 24 KT GOLD',
                      style: primaryColor16BoldTextStyle,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      watchlist = !watchlist;
                    });
                    if (watchlist) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Added to watchlist'),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Remove from watchlist'),
                      ));
                    }
                  },
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    width: 12.w,
                    height: 6.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        width: 0.6,
                        color: primaryColor.withOpacity(0.6),
                      ),
                    ),
                    child: Icon(
                      (watchlist) ? Icons.star : Icons.star_border,
                      size: 6.w,
                      color: primaryColor,
                    ),
                  ),
                ), //TODO Study this inkWell !!!
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 7.h,
                  width: 16.w,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/crypto_icon/btc.png',
                    width: 16.w,
                    height: 7.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current 24KT Gold Buy Price',
                      style: black14RegularTextStyle,
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'INR ${bp}',
                          style: black18SemiBoldTextStyle,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Icon(
                          data.buyChange > 0
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: data.buyChange > 0 ? greenColor : redColor,
                        ),
                        Text(
                          '${(data.buyChange).abs()}%',
                          style: black14BoldTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            width: double.infinity,
            height: 30.h,
            child: CryptoChartSyncfusion(type: "buy"),
          ),
        ],
      ),
    );
  }

  aboutPortfolio() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Instant Gold Details',
            style: primaryColor16BoldTextStyle,
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              aboutPortfolioItem(
                  'Gold Saved', '${walletbalace.toStringAsFixed(2)} GRAM'),
              aboutPortfolioItem('Current Value',
                  'INR ${(walletbalace * double.parse(data.sell.toString())).toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              aboutPortfolioItem('Average Buy Price', 'INR ${data.buy}'),
              Container(
                height: 75.0,
                width: (width - fixPadding * 6.0) / 2,
                padding: EdgeInsets.all(fixPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      color: blackColor.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gain/Loss',
                      style: grey14MediumTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          data.buyChange > 0
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: data.buyChange > 0 ? greenColor : redColor,
                        ),
                        Text(
                          '${(data.buyChange).abs()}%',
                          style: black14BoldTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  aboutPortfolioItem(title, value) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 10.h,
      width: (width - fixPadding * 6.0) / 2,
      padding: EdgeInsets.all(fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 1.0,
            color: blackColor.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: grey14MediumTextStyle,
          ),
          Text(
            value.toString(),
            style: black16BoldTextStyle,
          ),
        ],
      ),
    );
  }

  aboutItem(iconPath, title, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    width: 16.0,
                    height: 16.0,
                    fit: BoxFit.cover,
                  ),
                  width5Space,
                  Text(
                    title,
                    style: black14RegularTextStyle,
                  ),
                ],
              ),
              Text(
                value,
                style: black14MediumTextStyle,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.7,
          color: greyColor.withOpacity(0.4),
        ),
      ],
    );
  }

  buyByValue(double buyprice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: scaffoldBgColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            'BUY 24 KT GOLD BY VALUE',
                            style: primaryColor18BoldTextStyle,
                          ),
                        ),
                        height20Space,
                        Container(
                          width: double.infinity,
                          height: 0.2.h,
                          color: greyColor.withOpacity(0.4),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 8.h,
                                width: 16.w,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/crypto_icon/gold_ingots.png',
                                  width: 12.w,
                                  height: 6.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current 24KT Gold Buy Price',
                                    style: grey14BoldTextStyle,
                                  ),
                                  height5Space,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'INR ${(buyprice) + (buyprice * 0.03)}',
                                        style: black18BoldTextStyle,
                                      ),
                                      widthSpace,
                                      Text(
                                        '(GST 3% INCLUDED)',
                                        style: black12MediumTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Enter Value Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                          ),
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              labelStyle: primaryColor18BoldTextStyle,
                              suffix: Text(
                                'INR',
                                style: primaryColor18BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                            onChanged: (value) {
                              var val =
                                  double.parse('${amountController.text}');
                              var amount = (val /
                                  double.parse((buyprice + (buyprice * 0.03))
                                      .toString()));
                              setState(() {
                                valueController.text = '$amount';
                              });
                            },
                          ),
                        ),

                        height20Space,

                        // Amount Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                            backgroundColor: whiteColor,
                          ),
                          child: TextField(
                            enabled: false,
                            controller: valueController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Weight',
                              labelStyle: primaryColor18BoldTextStyle,
                              suffix: Text(
                                'GRAM  ',
                                style: primaryColor18BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                        height20Space,
                        // Buy Button
                        InkWell(
                          onTap: () async {
                            openCheckout();
                            Navigator.of(context).pop();
                          },
                          borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(fixPadding * 1.7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'Buy'.toUpperCase(),
                              style: white16MediumTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  buyByWeight(double buyPrice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: scaffoldBgColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            'BUY 24 KT GOLD BY WEIGHT',
                            style: primaryColor18BoldTextStyle,
                          ),
                        ),
                        height20Space,
                        Container(
                          width: double.infinity,
                          height: 0.2.h,
                          color: greyColor.withOpacity(0.4),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 8.h,
                                width: 16.w,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/crypto_icon/gold_ingots.png',
                                  width: 36.0,
                                  height: 36.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              widthSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current 24KT Gold Price',
                                    style: grey14BoldTextStyle,
                                  ),
                                  height5Space,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'INR ${buyPrice + (buyPrice * 0.03)}',
                                        style: black18BoldTextStyle,
                                      ),
                                      widthSpace,
                                      Text(
                                        '(GST 3% INCLUDED)',
                                        style: black12MediumTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Enter Value Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                          ),
                          child: TextField(
                            controller: valueController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'WEIGHT',
                              labelStyle: primaryColor18BoldTextStyle,
                              suffix: Text(
                                'GRAM',
                                style: primaryColor18BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                            onChanged: (value) {
                              var val = double.parse('${valueController.text}');
                              var amount = (val *
                                  double.parse((buyPrice + (buyPrice * 0.03))
                                      .toString()));
                              setState(() {
                                amountController.text = '$amount';
                              });
                            },
                          ),
                        ),

                        height20Space,

                        // Amount Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                            backgroundColor: whiteColor,
                          ),
                          child: TextField(
                            enabled: false,
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              labelStyle: primaryColor18BoldTextStyle,
                              prefix: Text(
                                'INR  ',
                                style: primaryColor18BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                        height20Space,

                        InkWell(
                          onTap: () async {
                            openCheckout();
                            Navigator.of(context).pop();
                          },
                          borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(fixPadding * 1.7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'Buy'.toUpperCase(),
                              style: white16MediumTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
