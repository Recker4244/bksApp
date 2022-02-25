import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/FlexiSubscription.dart';
import 'package:gold247/models/Installments.dart';
import 'package:gold247/models/Plan_Subscription.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/bottom_bar.dart';
import 'package:gold247/pages/profile/Orders.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:gold247/language/locale.dart';

enum adressType { Home, Work, Others }
adressType _character = adressType.Home;

class Adress_Details_Payment_Eshop extends StatefulWidget {
  final String Cartid;
  final Map deliverycharge;
  final String buysellid;
  final bool instantgold;
  final num amount;
  final num instantgoldbal;
  final num sell;

  Adress_Details_Payment_Eshop(
      {this.Cartid,
      this.amount,
      this.buysellid,
      this.instantgold,
      this.deliverycharge,
      this.instantgoldbal,
      this.sell});

  @override
  _Adress_Details_Payment_EshopState createState() =>
      _Adress_Details_Payment_EshopState();
}

class _Adress_Details_Payment_EshopState
    extends State<Adress_Details_Payment_Eshop> {
  final addresscontroller = TextEditingController();
  final PINcontroller = TextEditingController();
  final Landmarkcontroller = TextEditingController();
  String InstallID;
  String SubscribeID;
  DataS datas;
  PlanSubscriptions pSubs;
  @override
  void initState() {
    super.initState();
    getAddress();
  }

  getAddress() async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/address/user/${Userdata.id}'));
    request.body = '''''';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      PINcontroller.text = det['data']['pin'].toString();
      addresscontroller.text = det['data']['landMark'];
    } else {
      print(response.reasonPhrase);
    }
  }

  bool available = true;
  Future addAddres() async {
    var request = http.Request('POST', Uri.parse('${baseurl}/api/address/'));

    final body = {
      "user": "61bce82da171b2554eff3c8a",
      "pin": 226001,
      "landMark":
          "Ashok Marg · Ground Floor, Tekari Chambers Ashok Marg Lucknow",
      "isDefaultAddress": true
    };
    request.body = jsonEncode(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  checkPincode(String pincode) async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/pincode/search/$pincode'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      final status = det['msg'];
      if (status == "success") {
        setState(() {
          available = true;
        });
      } else {
        setState(() {
          available = false;
        });
      }
    } else {
      setState(() {
        available = false;
      });
    }
  }

  Future removefromwallet(num gold, num amount) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT', Uri.parse('${baseurl}/api/wallet/remove/${Userdata.id}'));

    final body = {
      "gold": gold,
      "transactions": {
        "paymentId": "RZP_00000043",
        "amount": amount,
        "status": "Debited"
      }
    };
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Map det_of_transaction;
  Future fetchTransactionid(String address) async {
    loadingDialog(context);
    var headers = {'Content-Type': 'application/json'};
    final url = Uri.parse('${baseurl}/api/transaction/create/${Userdata.id}');
    final body = {
      //"paymentId": payid,
      "status": "Order Placed",
      "amount": widget.amount,
      "mode": "COD",
      "instantGoldApplied": false
    };

    final response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      det_of_transaction = jsonDecode(response.body);
      final responseString = det_of_transaction['data'];
      if (widget.instantgold) {
        await removefromwallet(
            widget.instantgoldbal, widget.instantgoldbal * widget.sell);
      }
      await createOrder(address);
    } else {
      Navigator.of(context).pop();
      print(response.reasonPhrase);
    }
  }

  Map orderdetail;
  createOrder(String addressId) async {
    final url = Uri.parse('${baseurl}/api/order/');
    final body = {
      "user": Userdata.id,
      "cart": widget.Cartid,
      "transactions": det_of_transaction['data']['id'],
      "status": "Processing",
      "address": addressId,
      "deliveryCharge": widget.deliverycharge,
      "buySell": widget.buysellid,
      "instantGoldApplied": widget.instantgold
    };
    final response = await http.post(url, body: jsonEncode(body));
    if (response.statusCode == 200) {
      orderdetail = jsonDecode(response.body);
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            child: BottomBar(
              index: 4,
            ),
          ));
      Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            child: Orders(),
          ));
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
                            child: Text(orderdetail['otp']),
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

  Future addAddress() async {
    loadingDialog(context); //loadingDialog(context);
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST', Uri.parse('${baseurl}/api/address/'));
    request.headers.addAll(headers);
    final body = {
      "user": Userdata.id,
      "pin": int.parse(PINcontroller.text),
      "landMark": addresscontroller.text,
      "isDefaultAddress": true
    };
    request.body = jsonEncode(body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      fetchTransactionid(det['data']['savedAddress']['id']);
    } else {
      print(response.reasonPhrase);
    }
  }

  final _formkeyeshop = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          locale.addresstitle,
          style: TextStyle(
            color: scaffoldBgColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkeyeshop,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height20Space,
              height20Space,
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
                    child: TextFormField(
                      controller: addresscontroller,
                      validator: (value) =>
                          value.isEmpty ? "Field cannot be empty" : null,
                      keyboardType: TextInputType.streetAddress,
                      style: primaryColor16MediumTextStyle,
                      decoration: InputDecoration(
                        labelText: locale.Address,
                        labelStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                      ),
                      onChanged: (value) {},
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
                    child: TextFormField(
                      controller: PINcontroller,
                      validator: (value) =>
                          value.isEmpty ? "Field cannot be empty" : null,
                      keyboardType: TextInputType.number,
                      style: primaryColor16MediumTextStyle,
                      decoration: InputDecoration(
                        labelText: locale.PINCODE,
                        labelStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                      ),
                      onChanged: (value) {},
                      // onEditingComplete: () {
                      //   checkPincode(PINcontroller.text);
                      // },
                      onFieldSubmitted: (value) {
                        checkPincode(value);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 40),
              //   child: Container(
              //     color: whiteColor,
              //     // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
              //     child: Theme(
              //       data: ThemeData(
              //         primaryColor: whiteColor,
              //         textSelectionTheme: TextSelectionThemeData(
              //           cursorColor: primaryColor,
              //         ),
              //       ),
              //       child: TextFormField(
              //         controller: Landmarkcontroller,
              //         validator: (value) =>
              //             value.isEmpty ? "Field cannot be empty" : null,
              //         keyboardType: TextInputType.streetAddress,
              //         style: primaryColor16MediumTextStyle,
              //         decoration: InputDecoration(
              //           labelText: locale.LandMark,
              //           labelStyle: TextStyle(
              //               color: primaryColor,
              //               fontSize: 18,
              //               fontWeight: FontWeight.w600),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: const BorderRadius.all(
              //               const Radius.circular(10.0),
              //             ),
              //             borderSide: BorderSide(color: primaryColor, width: 1),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: const BorderRadius.all(
              //               const Radius.circular(10.0),
              //             ),
              //             borderSide: BorderSide(color: primaryColor, width: 1),
              //           ),
              //         ),
              //         onChanged: (value) {},
              //       ),
              //     ),
              //   ),
              // ),

              heightSpace,
              !available
                  ? Text(
                      locale.NotService,
                      style: black14SemiBoldTextStyle,
                    )
                  : Container(),
              height20Space,
              height20Space,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Adress_Type(),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: fixPadding * 6),
              //   child:
              // ),
              SizedBox(height: fixPadding * 3.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: InkWell(
                  onTap: () async {
                    if (_formkeyeshop.currentState.validate())
                      await addAddress();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          locale.Proceed.toUpperCase(),
                          style: TextStyle(
                            color: scaffoldBgColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Adress_Type extends StatefulWidget {
  @override
  _Adress_TypeState createState() => _Adress_TypeState();
}

class _Adress_TypeState extends State<Adress_Type> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          locale.AdressType,
          style: primaryColor16MediumTextStyle,
        ),
        height5Space,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Adress_Type_selector(),
          ],
        ),
      ],
    );
  }
}

class Adress_Type_selector extends StatefulWidget {
  //Adress_Type_selector(this.type);

  @override
  _Adress_Type_selectorState createState() => _Adress_Type_selectorState();
}

class _Adress_Type_selectorState extends State<Adress_Type_selector> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Home,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          locale.Home,
          style: primaryColor16MediumTextStyle,
        ),
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Work,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          locale.work,
          style: primaryColor16MediumTextStyle,
        ),
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Others,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          locale.others,
          style: primaryColor16MediumTextStyle,
        ),
      ],
    );
  }
}
