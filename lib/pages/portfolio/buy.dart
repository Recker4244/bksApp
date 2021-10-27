import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/Eshop/eshop.dart';
import 'package:gold247/pages/bottom_bar.dart';
import 'package:gold247/pages/cod/cod_buygold.dart';
import 'package:gold247/pages/currencyScreen/sell_gold.dart';
import 'package:gold247/pages/profile/bank_details.dart';
// import 'package:cryptox/pages/currencyScreen/currency_screen.dart';
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
  final String sub;
  const Deposit({Key key, this.balance, this.sub}) : super(key: key);

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
  //   var request = http.Request('GET', Uri.parse('${baseurl}/api/subscription/user/${Userdata.sId}'));
  //
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     final responseString=await response.stream.bytesToString();
  //     Map det=jsonDecode(responseString);
  //     subID=det['data'][0]['id'].toString();
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }

  String installmentId;
  void createInstallment(String payid) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${baseurl}/api/installment/create/${Userdata.sId}'));
    final body = {
      "paymentId": payid,
      "status": "Saved",
      "amount": amountController.text,
      "gold": weightController.text,
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
    final body = {"installmentId": installmentId};
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
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
      'amount': double.parse(amountController.text) * 100.0,
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

    return true;
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(response.paymentId);
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
                                          "INR ${data.buy.toDouble().toStringAsFixed(2)}",
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
                        color: whiteColor,
                        // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                        child: Theme(
                          data: ThemeData(
                            primaryColor: whiteColor,
                            textSelectionTheme: TextSelectionThemeData(
                              cursorColor: primaryColor,
                            ),
                          ),
                          child: TextField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            style: primaryColor16MediumTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Weight',
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              suffix: Text(
                                'GRAM',
                                style: primaryColor16MediumTextStyle,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                amountController.text = (data.sell.toDouble() *
                                        double.parse(weightController.text))
                                    .toStringAsFixed(2);
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        color: whiteColor,
                        // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                        child: Theme(
                          data: ThemeData(
                            primaryColor: whiteColor,
                            textSelectionTheme: TextSelectionThemeData(
                              cursorColor: primaryColor,
                            ),
                          ),
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: primaryColor16MediumTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              suffix: Text(
                                'INR',
                                style: primaryColor16MediumTextStyle,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
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
                        openCheckout();
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
            return SafeArea(
                child: Scaffold(
                    backgroundColor: scaffoldBgColor,
                    body: Text(" Oops !! No data ")));
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
                          "INR ${data.sell.toDouble().toStringAsFixed(2)}",
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
