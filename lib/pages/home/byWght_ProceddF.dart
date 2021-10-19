import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/cod/cod_Flexu.dart';
import 'package:gold247/pages/cod/cod_Stan.dart';
import 'package:gold247/pages/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../Eshop/COD_address.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class ByWeightFlexi extends StatefulWidget {
  double val;
  int duration;
  int mode;
  String planname;
  String CycleP;
  String shortName;
  num gold;
  ByWeightFlexi(
      {@required this.CycleP,
      this.duration,
      this.gold,
      this.val,
      this.planname,
      this.mode,
      this.shortName});
  @override
  _ByWeightFlexiState createState() => _ByWeightFlexiState();
}

class _ByWeightFlexiState extends State<ByWeightFlexi> {
  Razorpay _razorpay;
  String val = "0";
  final Rkey = 'rzp_test_wVVGuz2rxyrfFd';

  List portfolioItem;
  int buyprice;
  int endTime;
  buysellprice data = buysellprice();
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

  double bonusPercentage;
  Future getcalculation() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/calculation/5f3f9e5b5229ec11f804dd5c'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num d = responseString['data']['Percentage'];
      bonusPercentage = (d.toDouble()) / 100;
      return d;
    } else {
      print(response.reasonPhrase);
    }
  }

  void openCheckout() async {
    var options = {
      'key': Rkey,
      'amount': (widget.val * data.buy.toDouble()) * 100,
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

  Future<bool> init;
  Future<bool> initialise() async {
    await fetchData();
    await getcalculation();
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    return true;
  }

  String installmentID;
  pay(String id) async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/installment/create/${Userdata.sId}'));

    final body = {
      "paymentId": id,
      "status": "Saved",
      "amount": widget.val,
      "gold": widget.gold,
      "mode": "online"
    };
    request.body = jsonEncode(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);
      installmentID = s['data']['_id'];
    } else {
      print(response.reasonPhrase);
    }
    return installmentID;
  }

  createSubscription(String installmentid) async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/subscription/create/${Userdata.sId}'));

    final body = {
      "plan": {
        "mode": "Value",
        "duration": 20,
        "cyclePeriod": "6158779c9d83e000168038bc"
      },
      "userId": Userdata.sId,
      "status": "Running",
      "amount": widget.val,
      "installmentId": installmentID
    };
    request.body = jsonEncode(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);
    } else {
      print(response.reasonPhrase);
    }
  }

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

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    installmentID = await pay(response.paymentId);
    createSubscription(installmentID);
    return showDialog(
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
                          child: Text('otp'),
                        )),
                      ),
                    ),
                    height20Space,
                    Center(
                        child: Text(
                      "Tap to Copy Verification OTP",
                      style: black12MediumTextStyle,
                    )),
                    heightSpace,
                    Center(
                        child: Text(
                      'Show this code while you visit Store',
                      style: black12MediumTextStyle,
                    ))
                  ],
                ),
              ),
            ));
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
              return SafeArea(
                  child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: whiteColor,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: primaryColor,
                  centerTitle: true,
                  title: Text(
                    widget.planname,
                    style: white18MediumTextStyle,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(fixPadding * 1.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                          ),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: blackColor.withOpacity(0.05),
                              spreadRadius: 4,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(goldIngotsPath),
                                  ),
                                ),
                                widthSpace,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '24 KT GOLD',
                                      style: primaryColor18BoldTextStyle,
                                    ),
                                    height5Space,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'BUY RATE:',
                                          style: grey14BoldTextStyle,
                                        ),
                                        Icon(
                                          data.buyChange > 0
                                              ? Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: data.buyChange > 0
                                              ? greenColor
                                              : redColor,
                                        ),
                                        Text(
                                          '${data.buyChange}%',
                                          style: black14BoldTextStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "${data.buy.toStringAsFixed(2)} INR", //TODO buyprice
                              style: black18BoldTextStyle,
                            ),
                          ],
                        ),
                      ),
                      heightSpace,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CountdownTimer(
                          onEnd: () async {
                            data = await fetchData();
                            if (mounted)
                              setState(() {
                                endTime =
                                    DateTime.now().millisecondsSinceEpoch +
                                        1000 * 30;
                              });
                          },
                          endTime: endTime,
                          widgetBuilder: (BuildContext context, C) {
                            if (C == null) {
                              return Text('Price changing..',
                                  style: black18BoldTextStyle);
                            }
                            return Text(
                                "Price Changes in ${C.min == null ? 0 : C.min}:${C.sec} minutes",
                                style: black18BoldTextStyle);
                          },
                        ),
                      ),
                      height20Space,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: fixPadding * 2),
                              padding: EdgeInsets.all(fixPadding * 2),
                              child: widget.mode == 1
                                  ? Text(
                                      "${(widget.val * data.buy.toDouble()).toStringAsFixed(2)} INR",
                                      style: primaryColor16BoldTextStyle,
                                    )
                                  : Text(
                                      "${(widget.val * data.buy.toDouble()).toStringAsFixed(2)} INR",
                                      style: primaryColor16BoldTextStyle,
                                    )),
                          Your_Portfolio(
                              "${widget.val.toStringAsFixed(2)} GRAM/${widget.shortName}",
                              "${(widget.val * widget.duration * bonusPercentage).toStringAsFixed(2)} GRAM",
                              "${widget.duration} ${widget.shortName}",
                              "${(widget.val * widget.duration * (1 + bonusPercentage)).toStringAsFixed(2)} GRAM"),
                          Text(
                            '   Choose Payment Mode',
                            style: primaryColor16MediumTextStyle,
                          ),
                          heightSpace,
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: fixPadding * 2),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          'Use Payment Gateway Service to pay instantly',
                                          style: black16BoldTextStyle,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          'Online Payment',
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
                          height20Space,
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.size,
                                      alignment: Alignment.bottomCenter,
                                      child: Adress_Details_Payment_Flex(
                                        mode: "Weight",
                                        amount: widget.gold.toString(),
                                        duration: widget.duration,
                                        CPID: widget.CycleP,
                                        gold: widget.val.toStringAsFixed(2),
                                      )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: fixPadding * 2),
                              padding: EdgeInsets.all(fixPadding * 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    size: 40,
                                  ),
                                  width20Space,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          'You can pay at your doorstep',
                                          style: black16BoldTextStyle,
                                          softWrap: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          'Cash On Delivery',
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
                          height20Space,
                        ],
                      ),
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
}

Your_Portfolio(String saveGold, String BonusC, String Duration, String Saving) {
  return Container(
    height: 330,
    child: Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Your Portfolio',
            style: primaryColor16MediumTextStyle,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Portfolio_card('Saving Gold', saveGold.toString()),
                Portfolio_card(
                  'Bonus By Maturity',
                  BonusC,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Portfolio_card('Duration', Duration.toString()),
                Portfolio_card('Total Saving', Saving),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class Portfolio_card extends StatelessWidget {
  Portfolio_card(this.tag, this.text);

  final String tag;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: blackColor.withOpacity(0.05),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tag,
                  style: primaryColor16BoldTextStyle,
                ),
                Text(
                  text,
                  style: primaryColor16MediumTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Payment_Method extends StatelessWidget {
  final String gold;
  final String amount;
  final PlanID;
  final CPID;
  final String mode;

  final int duration;
  final indentifier;
  Payment_Method(
      {this.amount,
      this.gold,
      this.PlanID,
      this.CPID,
      this.mode,
      this.duration,
      this.indentifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   '   Choose Payment Mode',
        //   style: primaryColor16MediumTextStyle,
        // ),
        // heightSpace,
        // Payment_Card(
        //   FontAwesomeIcons.creditCard,
        //   'Use Payment Gateway Service to pay instantly',
        //   'Online Payment',
        //   Adress_Details_Payment(),
        // ),
        //heightSpace,
        Payment_Card(
          Icons.location_on,
          'You can pay at your doorstep',
          'Cash On Delivery',
          Adress_Details_Payment_Flex(
            amount: amount,
            gold: gold,
            PlanID: PlanID,
            CPID: CPID,
            duration: duration,
            mode: mode,
          ),
        ),
      ],
    );
  }
}

class Payment_Card extends StatelessWidget {
  Payment_Card(
    this.icon,
    this.text,
    this.tag,
    this.navigateTo,
  );

  final IconData icon;

  final String tag;
  final String text;

  final Widget navigateTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.size,
                alignment: Alignment.bottomCenter,
                child: navigateTo));
      },
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: fixPadding * 2),
        padding: EdgeInsets.all(fixPadding * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
            ),
            width20Space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: Text(
                    tag,
                    style: black16BoldTextStyle,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    text,
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
    );
  }
}
