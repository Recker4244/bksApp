import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/Eshop/eshop.dart';
import 'package:gold247/pages/bottom_bar.dart';
import 'package:gold247/pages/cod/cod_buygold.dart';
import 'package:gold247/pages/instantGold/sell_gold.dart';
import 'package:gold247/pages/market/market.dart';
import 'package:gold247/pages/profile/bank_details.dart';
// import 'package:cryptox/pages/instantGold/currency_screen.dart';
import 'package:gold247/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold247/language/locale.dart';

class Deposit extends StatefulWidget {
  final String balance;
  final num minGold;
  final String sub;
  const Deposit({Key key, this.balance, this.sub, this.minGold})
      : super(key: key);

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final weightController = TextEditingController();
  final amountController = TextEditingController();
  int endTime;
  final portfolioItem = [
    {
      'name': '24 KT GOLD',
      'shortName': 'BTC',
      'image': 'assets/crypto_icon/gold_ingots.png',
      'value': 'INR 4,380.00',
      'status': 'down',
      'change': '0.00%',
      'coinTotal': 'Sell Rate'
    }
  ];

  // void getsubId()async{
  //   var request = http.Request('GET', Uri.parse('${baseurl}/api/subscription/user/${Userdata.id}'));
  //
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     final responseString=await response.stream.bytesToString();
  //     Map det=jsonDecode(responseString);
  //     subID=det['data'][0]['_id'].toString();
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }

  String installmentId;
  void createInstallment(String payid) async {
    loadingDialog(context);
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${baseurl}/api/installment/create/${Userdata.id}'));
    final body = {
      "paymentId": payid,
      "status": "Saved",
      "amount": num.parse(num.parse(amountController.text).toStringAsFixed(2)),
      "gold": num.parse(num.parse(weightController.text).toStringAsFixed(2)),
      "mode": "online"
    };
    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      installmentId = det['data']['id'];
      addInstallmentSubs();
    } else {
      print(response.reasonPhrase);
    }
  }

  void addInstallmentSubs() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            '${baseurl}/api/subscription/installments/add/${widget.sub}'));
    final body = {"installmentId": "$installmentId"};
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomBar(
                    index: 2,
                  )));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Market()));

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
                        "${num.parse(num.parse(weightController.text).toStringAsFixed(2))} GRAM SOLD",
                        style: black16BoldTextStyle,
                      )),
                      Center(
                          child: Text(
                        '${DateTime.now()}',
                        style: black14MediumTextStyle,
                      )),
                      heightSpace,
                      // Center(
                      //     child: Text(
                      //   'Money will be credited to your bank account ending with ${bankdetail.accountnum.substring(bankdetail.accountnum.length - 4)} within 72 Hours',
                      //   style: black14MediumTextStyle,
                      // )),
                    ],
                  ),
                ),
              ));
    } else {
      print(response.reasonPhrase);
    }
  }

  Razorpay _razorpay;
  String val = "0";
  final Rkey = 'rzp_test_wVVGuz2rxyrfFd';
  buysellprice data = buysellprice();
  Future fetchData() async {
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/buy-sell-price/letest'));

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

  void openCheckout() async {
    var options = {
      'key': Rkey,
      'amount': (double.parse(amountController.text)) * 100.0,
      'name': "Flexi Plan",
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

  Future<bool> initialise() async {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 45;
    data = await fetchData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    weightController.text = widget.minGold.toStringAsFixed(2);
    amountController.text = (widget.minGold * data.buy).toStringAsFixed(2);
    return true;
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await createInstallment(response.paymentId.toString());
  }

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
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  Future<bool> init;
  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
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
                    child: SpinKitRing(
                  duration: Duration(milliseconds: 700),
                  color: primaryColor,
                  size: 40.0,
                  lineWidth: 1.2,
                ))),
          );
        } else {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: scaffoldBgColor,
              appBar: AppBar(
                backgroundColor: primaryColor,
                titleSpacing: 0.0,
                title: Text(
                  'BUY GOLD',
                  style: TextStyle(
                    color: scaffoldBgColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    height20Space,
                    Text(
                      '${widget.balance} GRAM',
                      style: black18BoldTextStyle,
                    ),
                    height5Space,
                    Text(
                      'Available Balance',
                      style: black12RegularTextStyle,
                    ),
                    // SizedBox(height: fixPadding * 3.0),
                    ColumnBuilder(
                      itemCount: portfolioItem.length,
                      itemBuilder: (context, index) {
                        final item = portfolioItem[index];
                        return Padding(
                          padding: (index != portfolioItem.length - 1)
                              ? EdgeInsets.fromLTRB(fixPadding * 2.0,
                                  fixPadding * 2.0, fixPadding * 2.0, 0.0)
                              : EdgeInsets.all(fixPadding * 2.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: whiteColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    item['image'],
                                    height: 40.0,
                                    width: 40.0,
                                    fit: BoxFit.cover,
                                  ),
                                  widthSpace,
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['name'],
                                              style:
                                                  primaryColor18BoldTextStyle,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Buy Rate',
                                                  style: black12MediumTextStyle,
                                                ),
                                                widthSpace,
                                                Icon(
                                                  data.buyChange > 0
                                                      ? Icons.arrow_drop_up
                                                      : Icons.arrow_drop_down,
                                                  color: data.buyChange > 0
                                                      ? greenColor
                                                      : redColor,
                                                ),
                                                Text(
                                                  '${data.buyChange.abs()}%',
                                                  style: black12MediumTextStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "INR ${data.buy.toStringAsFixed(2)}",
                                          style: black16BoldTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    myPortfolioItems(),
                    // Amount Textfield Start

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 10.h,
                        //color: Colors.amber,
                        // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                        child: Theme(
                          data: ThemeData(
                            errorColor: primaryColor,
                            primaryColor: whiteColor,
                            textSelectionTheme: TextSelectionThemeData(
                              cursorColor: primaryColor,
                            ),
                          ),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Please enter the weight you want to save";
                              if (num.parse(value) < widget.minGold) {
                                return "Minimum Weightt: ${widget.minGold.toStringAsFixed(2)}";
                              }
                              if (num.parse(value) <= 0)
                                return "Weight must be greater than 0";
                              return null;
                            },
                            onChanged: (String value) {
                              setState(() {
                                amountController.text =
                                    (double.parse(value) * data.buy)
                                        .toStringAsFixed(2);
                              });
                            },
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              fillColor: whiteColor,
                              suffix: Text(locale.GRAM,
                                  style: primaryColor18BoldTextStyle),
                              labelText: locale.WeightofGold,
                              labelStyle: primaryColor18BoldTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        //color: whiteColor,
                        // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                        child: Theme(
                          data: ThemeData(
                            primaryColor: whiteColor,
                            textSelectionTheme: TextSelectionThemeData(
                              cursorColor: primaryColor,
                            ),
                          ),
                          child: TextField(
                            //enabled: false,
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              fillColor: whiteColor,
                              filled: true,
                              labelText: 'Amount',
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              suffix: Text(
                                'INR',
                                style: primaryColor16MediumTextStyle,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 0.7),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: fixPadding * 3.0),

                    height5Space,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountdownTimer(
                        onEnd: () async {
                          data = await fetchData();
                          if (mounted)
                            setState(() {
                              endTime = DateTime.now().millisecondsSinceEpoch +
                                  1000 * 45;
                            });
                        },
                        endTime: endTime,
                        widgetBuilder: (BuildContext context, C) {
                          if (C == null) {
                            return Text('Price changing..',
                                style: black18BoldTextStyle);
                          }
                          return Text(
                              "You have ${C.min == null ? 0 : C.min}:${C.sec} minutes",
                              style: black18BoldTextStyle);
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "You can also prefer to partly sell or redeem by entering your preferred weight",
                            textAlign: TextAlign.center,
                            style: black14SemiBoldTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (num.parse(weightController.text) >= 49000) {
                          bool veri = await pan(context);
                          if (veri) {
                            openCheckout();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("PAN verification failed")));
                          }
                        } else {
                          openCheckout();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: fixPadding * 2),
                        padding: EdgeInsets.all(fixPadding * 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.creditCard,
                              size: 40,
                            ),
                            width20Space,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Online Payment',
                                    style: black16BoldTextStyle,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    'Use Payment Gateway Service to pay instantly',
                                    style: black14RegularTextStyle,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Adress_Details_Payment_Buygold(
                                        amount: amountController.text,
                                        gold: weightController.text,
                                        subsId: widget.sub)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: fixPadding * 2),
                        padding: EdgeInsets.all(fixPadding * 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on_outlined,
                              size: 40,
                            ),
                            width20Space,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    "Collect from your location",
                                    style: black16BoldTextStyle,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "You can pay at your doorstep",
                                    style: black14RegularTextStyle,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return errorScreen;
          }
        }
      },
    );
  }

  myPortfolioItems() {
    return ColumnBuilder(
      itemCount: portfolioItem.length,
      itemBuilder: (context, index) {
        final item = portfolioItem[index];
        return Padding(
          padding: (index != portfolioItem.length - 1)
              ? EdgeInsets.fromLTRB(
                  fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0)
              : EdgeInsets.all(fixPadding * 2.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    item['image'],
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                  ),
                  widthSpace,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: primaryColor18BoldTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${item['coinTotal']}',
                                  style: black12MediumTextStyle,
                                ),
                                widthSpace,
                                Icon(
                                  data.sellChange > 0
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: data.sellChange > 0
                                      ? greenColor
                                      : redColor,
                                ),
                                Text(
                                  '${data.sellChange.abs()}%',
                                  style: black12MediumTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "INR ${data.sell.toStringAsFixed(2)}",
                          style: black16BoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
