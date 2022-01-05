import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/AddressDetail.dart';
import 'package:gold247/models/appointment.dart';
import 'package:gold247/models/cart.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/cod/cod_Flexu.dart';
import 'package:gold247/pages/cod/cod_eshop.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/widget/column_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:gold247/language/locale.dart';

var redeemBalance = 0.0;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Razorpay _razorpay;
  String val = "0";
  final Rkey = 'rzp_test_wVVGuz2rxyrfFd';

  List portfolioItem;
  int buyprice;

  Map create_order_response;
  void createorder() async {
    final url = Uri.parse('${baseurl}/api/order/');
    final body = {
      "user": Userdata.id,
      "cart": det_of_cart['data']['_id'],
      "transactions": det_of_transaction['data']['_id'],
      "status": "Processing",
      "address": list_of_address[0].sId,
      "deliveryCharge": deliverycharges['_id'],
      "buySell": buysellid.toString(),
      "instantGoldApplied": int.parse(availablegold.toString())
    };
    final response = await http.post(url, body: jsonEncode(body));
    if (response.statusCode == 200) {
      create_order_response = jsonDecode(response.body);
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
                            child: Text(create_order_response['otp']),
                          )),
                        ),
                      ),
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
    } else {
      print(response.reasonPhrase);
    }
  }

  List<Address> list_of_address = [];
  void getaddress() async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/address/user/${Userdata.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      list_of_address = List<Address>.from(l.map((e) => Address.fromJson(e)));
    } else {
      print(response.reasonPhrase);
    }
  }

  Map det_of_transaction;
  void fetchTransactionid(String payid) async {
    final url = Uri.parse('${baseurl}/api/transaction/create/${Userdata.id}');
    final body = {
      "paymentId": payid,
      "status": "placed",
      "amount": finalResult,
      "mode": "online"
    };
    final response = await http.post(url, body: jsonEncode(body));
    if (response.statusCode == 200) {
      det_of_transaction = jsonDecode(response.body);
      final responseString = det_of_transaction['data'];
      //final transcationId = responseString['_id'];
    } else {
      print(response.reasonPhrase);
    }
  }

  dynamic sell;
  dynamic buy;
  dynamic buysellid;
  Future buysellletest() async {
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/buy-sell-price/letest'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      sell = det['data']['sell'];
      buy = det['data']['sell'];
      buysellid = det['data']['_id'];
    } else {
      print(response.reasonPhrase);
    }
  }

  dynamic instantgold;
  Future getInstantGold() async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/wallet/6158849d3b5cb8a0c1d96040'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      instantgold = det['data']['gold'];
    } else {
      print(response.reasonPhrase);
    }
  }

  Map deliverycharges;
  Future<String> getDeliveryCharge() async {
    var request = http.Request('GET',
        Uri.parse('${baseurl}/api/calculation/617f87af1cff6bdaddd477eb'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);

      deliverycharges = det['data'];
    } else {
      print(response.reasonPhrase);
    }
    return deliverycharges.toString();
  }

  Map det_of_cart;
  List<CartItems> list_of_cartItems = [];
  Future getCartdetails() async {
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/cart/${Userdata.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      det_of_cart = jsonDecode(responseString);

      Iterable l = det_of_cart['data']['items'];
      list_of_cartItems =
          List<CartItems>.from(l.map((e) => CartItems.fromJson(e)));
    } else {
      print(response.reasonPhrase);
    }
  }

  void openCheckout() async {
    var options = {
      'key': Rkey,
      'amount': ((finalResult) * 100.0).toStringAsFixed(2),
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
    await buysellletest();
    await getInstantGold();
    await getDeliveryCharge();
    await getCartdetails();
    await calAvailablegold();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    ToPay(false);
    return true;
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await fetchTransactionid(response.paymentId.toString());
    await createorder();
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

  String Subtotal() {
    double subtotal = 0.0;
    for (int i = 0; i < list_of_cartItems.length; i++) {
      subtotal = subtotal +
          (list_of_cartItems[i].quantity * list_of_cartItems[i].totalAmount);
    }
    return subtotal.toStringAsFixed(2);
  }

  bool ispressed = false;
  double finalResult = 0.0;
  double availablebalance = 0.0;
  void ToPay(bool isavailable) {
    double subTotal = double.parse(Subtotal());
    double delivery = double.parse(deliverycharges['Percentage'].toString());

    double redeemGold = redeemBalance;
    availablebalance =
        double.parse(instantgold.toString()) * double.parse(sell.toString());

    if (isavailable) {
      finalResult = availablebalance > (subTotal + delivery - redeemGold)
          ? 0
          : (subTotal + delivery - redeemGold - availablebalance);
      setState(() {
        availablebalance = availablebalance > (subTotal + delivery - redeemGold)
            ? (availablebalance - (subTotal + delivery - redeemGold))
            : 0;
      });
    } else {
      finalResult = subTotal + delivery - redeemGold;
    }
  }

  double availablegold = 0.0;
  calAvailablegold() {
    availablegold = finalResult / sell;
    return availablegold;
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
              appBar: AppBar(
                title: Text(
                  'Cart',
                ),
              ),
              backgroundColor: scaffoldBgColor,
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  heightSpace,
                  cartGold(),
                  summary(),
                  Text(
                    '   Choose Payment Mode',
                    style: primaryColor18BoldTextStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      openCheckout();
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
                                  'Use Payment Gateway Service to pay instantly',
                                  style: black16BoldTextStyle,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
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
                  SizedBox(
                    height: 2.0,
                  ),
                  Payment_Card(
                    Icons.location_on,
                    'You can pay at your doorstep',
                    'Cash On Delivery',
                    Adress_Details_Payment_Eshop(
                      Cartid: det_of_cart['data']['_id'].toString(),
                      deliverycharge: deliverycharges,
                      buysellid: buysellid,
                      instantgold: availablegold.toStringAsFixed(2),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return errorScreen;
          }
        }
      },
    );
  }

  cartGold() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ColumnBuilder(
          itemCount: list_of_cartItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: (index != list_of_cartItems.length - 1)
                  ? EdgeInsets.fromLTRB(
                      fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0)
                  : EdgeInsets.all(fixPadding * 2.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.center,
                          child: CurrencyScreen()));
                },
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(fixPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        color: blackColor.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/crypto_icon/btc.png',
                        height: 50.0,
                        width: 50.0,
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
                                  "${list_of_cartItems[index].itemDetail.grossweight} GRAM ${list_of_cartItems[index].itemDetail.composition[0].metalGroup.karatage} ${list_of_cartItems[index].itemDetail.item.name.toUpperCase()}",
                                  style: primaryColor16BoldTextStyle,
                                ),
                                // TODO
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "INR ${list_of_cartItems[index].totalAmount.toStringAsFixed(2)} ",
                                      style: black16BoldTextStyle,
                                    ),
                                    // widthSpace,
                                    // ('up' == 'up')
                                    //     ? Icon(
                                    //         Icons.arrow_drop_up,
                                    //         color: primaryColor,
                                    //       )
                                    //     : Icon(
                                    //         Icons.arrow_drop_down,
                                    //         color: redColor,
                                    //       ),
                                    // Text(
                                    //   "item['change']",
                                    //   style: black12RegularTextStyle,
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      )),
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    list_of_cartItems[index]
                                        .quantity
                                        .toString(),
                                    style: white16BoldTextStyle,
                                  ),
                                  padding: EdgeInsets.all(10),
                                ),
                              ],
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
      ],
    );
  }

  summary() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' Summary',
            style: primaryColor18BoldTextStyle,
          ),
          Padding(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sub-Total',
                      style: primaryColor16MediumTextStyle,
                    ),
                    Text(
                      "INR ${Subtotal()}",
                      style: primaryColor16MediumTextStyle,
                    ),
                  ],
                ),
                divider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Delivery Charges',
                      style: primaryColor16MediumTextStyle,
                    ),
                    Text(
                      'INR ${deliverycharges['Percentage'].toString()}',
                      style: primaryColor16MediumTextStyle,
                    ),
                  ],
                ),
                divider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Redeem Gold',
                      style: primaryColor16MediumTextStyle,
                    ),
                    Text(
                      redeemBalance.toStringAsFixed(2),
                      style: primaryColor16MediumTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                ispressed = !ispressed;
                ToPay(ispressed);
              });
            },
            child: Container(
              height: 60,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: fixPadding * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Available Instant Gold Balance',
                            style: primaryColor14MediumTextStyle,
                          ),
                          Text(
                            '${double.parse(instantgold.toString()).toStringAsFixed(2)} GRAM',
                            style: primaryColor14MediumTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        'INR ${availablebalance.toStringAsFixed(2)}',
                        style: primaryColor16MediumTextStyle,
                      ),
                    ],
                  ),
                ),
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
              ),
            ),
          ),
          height20Space,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                ' TO PAY :',
                style: primaryColor18BoldTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: fixPadding * 2,
                ),
                child: Text(
                  ' INR ${finalResult.toStringAsFixed(2)}',
                  style: primaryColor18BoldTextStyle,
                ),
              ),
            ],
          ),
        ],
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
