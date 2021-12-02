import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
import 'package:gold247/language/locale.dart';

class standardValue extends StatefulWidget {
  String durationString;
  int duration;
  String cycleid;
  String planname;
  String planID;
  String shortname;
  num min;
  standardValue(
      {this.planID,
      this.shortname,
      this.duration,
      this.planname,
      this.cycleid,
      this.min,
      this.durationString});
  @override
  _standardValueState createState() => _standardValueState();
}

class _standardValueState extends State<standardValue> {
  Razorpay _razorpay;
  String val = "0";
  final Rkey = 'rzp_test_wVVGuz2rxyrfFd';
  TextEditingController valueController = TextEditingController();
  TextEditingController amountController = TextEditingController(text: "0.0");

  List portfolioItem;
  int buyprice;
  int endTime;
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

  double bonusPercentage;
  Future getcalculation() async {
    var request = http.Request('GET',
        Uri.parse('${baseurl}/api/calculation/617f87af1cff6bdaddd477eb'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num d = responseString['data'][0]['Percentage'];
      bonusPercentage = (d.toDouble()) / 100;
      return d;
    } else {
      print(response.reasonPhrase);
    }
  }

  openCheckout() async {
    var options = {
      'key': Rkey,
      'amount': (double.parse(valueController.text)) * 100.0,
      'name': "Standard Plan",
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
    valueController = TextEditingController(text: widget.min.toString());
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  String installmentID;
  pay(String id) async {
    var request = http.Request(
        'POST', Uri.parse('${baseurl}/api/installment/create/${Userdata.id}'));

    final body = {
      "paymentId": id,
      "status": "Saved",
      "amount": amountController.text,
      "gold": valueController.text,
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
        'POST', Uri.parse('${baseurl}/api/subscription/create/${Userdata.id}'));
    request.bodyFields = {
      "userId": Userdata.id,
      "status": "Running",
      "amount": amountController.text,
      "planId": widget.planID, //Todo not in instant
      "installmentId": installmentID
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);
      // pSubs = PlanSubscriptions.fromJson(s);
      // datas = DataS.fromJson(s['data']);

      // SubscribeID = datas.sId;
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var locale = AppLocalizations.of(context);
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
                      locale.REQUESTPLACED,
                      style: black16BoldTextStyle,
                    )),
                    Center(
                        child: Text(
                      locale.SUCCESS,
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
                          child: Text(response.paymentId),
                        )),
                      ),
                    ),
                    height20Space,
                    Center(
                        child: Text(
                      locale.taptocopy,
                      style: black12MediumTextStyle,
                    )),
                    heightSpace,
                    Center(
                        child: Text(
                      locale.showcode,
                      style: black12MediumTextStyle,
                    ))
                  ],
                ),
              ),
            ));
  }

  _handlePaymentError(PaymentFailureResponse response) {
    var locale = AppLocalizations.of(context);
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
                      locale.REQUESTFAILED,
                      style: black16BoldTextStyle,
                    )),
                    Center(
                        child: Text(
                      locale.FAILED,
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
                    duration: Duration(milliseconds: 500),
                    color: primaryColor,
                    size: 40.0,
                    lineWidth: 1.2,
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
                      Icons.arrow_back,
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
                                          locale.BuyRate,
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
                              data.buy, //TODO buyprice
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
                                "${locale.priceChange} ${C.min == null ? 0 : C.min}:${C.sec} minutes",
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
                          Padding(
                            padding: const EdgeInsets.all(fixPadding * 2),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: whiteColor,
                              ),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the amount you want to save';
                                  }
                                  if (num.parse(value) < widget.min) {
                                    return "Minimum Amount: ${widget.min.toStringAsFixed(2)}";
                                  }

                                  return null;
                                },
                                onChanged: (String value) {
                                  setState(() {
                                    if (value != null && value.isNotEmpty) {
                                      amountController.text = (num.parse(value)
                                                  .toDouble() /
                                              num.parse(data.buy).toDouble())
                                          .toStringAsFixed(2);
                                    }
                                  });
                                },
                                controller: valueController,
                                cursorColor: primaryColor,
                                keyboardType: TextInputType.number,
                                style: primaryColor18BoldTextStyle,

                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1),
                                  ),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1),
                                  ),
                                  fillColor: whiteColor,
                                  labelText: locale.value,
                                  labelStyle: primaryColor18BoldTextStyle,
                                  suffix: Text(
                                    'INR',
                                    style: primaryColor18BoldTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                                //  InputDecoration(
                                //   focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: primaryColor, width: 2.0),
                                //   ),
                                //   labelText: locale.value,
                                //   labelStyle: primaryColor18BoldTextStyle,
                                //   suffix: Text(
                                //     'INR',
                                //     style: primaryColor18BoldTextStyle,
                                //   ),
                                //   border: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: primaryColor, width: 0.7),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          Your_Portfolio(
                            "${amountController.text}GM/${widget.shortname}",
                            "${(double.parse(amountController.text) * widget.duration * bonusPercentage).toStringAsFixed(2)} GRAM",
                            "${widget.durationString}",
                            "${(double.parse(amountController.text) * widget.duration * (1 + bonusPercentage)).toStringAsFixed(2)} GRAM",
                          ),
                          Padding(
                            padding: const EdgeInsets.all(fixPadding * 2),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                              ),
                              child: TextField(
                                enabled: false,
                                controller: amountController,
                                keyboardType: TextInputType.text,
                                style: primaryColor18BoldTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Weight of Gold',
                                  labelStyle: primaryColor18BoldTextStyle,
                                  suffix: Text(
                                    locale.GRAM,
                                    style: primaryColor18BoldTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: fixPadding * 2),
                            child: Text(
                              locale.choosePayment,
                              style: primaryColor16MediumTextStyle,
                            ),
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
                                          locale.herepayment,
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
                                          locale.usePayment,
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
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Adress_Details_Payment_Stan(
                                            gold: amountController.text,
                                            amount: valueController.text,
                                            PlanID: widget.planID,
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
                                    Icons.add_location,
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
                                          locale.useCOC,
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
                                          locale.hereCOC,
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
                    ],
                  ),
                ),
              ));
            } else {
              return errorScreen;
            }
          }
        });
  }

  Your_Portfolio(
      String saveGold, String BonusC, String Duration, String Saving) {
    var locale = AppLocalizations.of(context);
    return Container(
      height: 330,
      child: Padding(
        padding: EdgeInsets.all(fixPadding * 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              locale.yourPortfolio,
              style: primaryColor16MediumTextStyle,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Portfolio_card(locale.Saving, saveGold),
                  Portfolio_card(
                    locale.Bonus,
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
                  Portfolio_card(locale.duration, Duration.toString()),
                  Portfolio_card(locale.totalSaving, Saving),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                  style: primaryColor16MediumTextStyle.copyWith(
                      color: Colors.black),
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
    var locale = AppLocalizations.of(context);
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
          locale.hereCOC,
          locale.useCOC,
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
    // return GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         PageTransition(
    //             type: PageTransitionType.size,
    //             alignment: Alignment.bottomCenter,
    //             child: navigateTo));
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: whiteColor,
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(10),
    //         )),
    //     width: double.infinity,
    //     margin: EdgeInsets.symmetric(horizontal: fixPadding * 2),
    //     padding: EdgeInsets.all(fixPadding * 2),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: <Widget>[
    //         Icon(
    //           icon,
    //           size: 40,
    //         ),
    //         width20Space,
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             SizedBox(
    //               width: 150,
    //               child: Text(
    //                 tag,
    //                 style: black16BoldTextStyle,
    //                 softWrap: true,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width * 0.5,
    //               child: Text(
    //                 text,
    //                 style: black14RegularTextStyle,
    //                 softWrap: true,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
