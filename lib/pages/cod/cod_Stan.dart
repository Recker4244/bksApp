import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/FlexiSubscription.dart';
import 'package:gold247/models/Installments.dart';
import 'package:gold247/models/Plan_Subscription.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/bottom_bar.dart';
import 'package:gold247/pages/buySccessFailScreen/buy_fail_screen.dart';
import 'package:gold247/pages/buySccessFailScreen/buy_success_screen.dart';
import 'package:gold247/pages/portfolio/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum adressType { Home, Work, Others }
adressType _character = adressType.Home;

class Adress_Details_Payment_Stan extends StatefulWidget {
  final String gold;
  final String mode;
  final String amount;
  final int duration;
  final int indentifier;
  final String PlanID;
  final String CPID;
  Adress_Details_Payment_Stan(
      {this.amount,
      this.gold,
      this.PlanID,
      this.CPID,
      this.mode,
      this.duration,
      this.indentifier});

  @override
  _Adress_Details_Payment_StanState createState() =>
      _Adress_Details_Payment_StanState();
}

class _Adress_Details_Payment_StanState
    extends State<Adress_Details_Payment_Stan> {
  final addresscontroller = TextEditingController();
  final PINcontroller = TextEditingController();
  final Landmarkcontroller = TextEditingController();
  String InstallID;
  String SubscribeID;
  DataS datas;
  PlanSubscriptions pSubs;

  bool available = true;
  Future addAddress() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRing(
                      color: primaryColor,
                      size: 40.0,
                      lineWidth: 1.2,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Please Wait..',
                      style: grey14MediumTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    //loadingDialog(context);
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST', Uri.parse('${baseurl}/api/address/'));
    request.headers.addAll(headers);
    final body = {
      "user": Userdata.id,
      "pin": PINcontroller.text,
      "landMark": Landmarkcontroller.text,
      "isDefaultAddress": true
    };
    request.body = jsonEncode(body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      pay(det['id']);
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
      if (status == "pincode found") {
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

  DataIN info;
  String installmentID;
  String otp;
  pay(String adressId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${baseurl}/api/installment/create/${Userdata.id}'));

    final body = {
      "user": Userdata.id,
      "status": "Processing",
      "amount": num.parse(num.parse(widget.amount).toStringAsFixed(2)),
      "gold": num.parse(num.parse(widget.gold).toStringAsFixed(2)),
      "mode": "COD",
      "address": adressId
    };
    request.body = jsonEncode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);
      installmentID = s['data']['id'];
      otp = s['data']['otp'];
      createSubscription(installmentID);
    } else {
      print(response.reasonPhrase);
    }
    return installmentID;
  }

  createSubscription(String installmentid) async {
    var headers = {'Content-Type': 'application/json'};
    var locale = AppLocalizations.of(context);

    var request = http.Request(
        'POST', Uri.parse('${baseurl}/api/subscription/create/${Userdata.id}'));

    final body = {
      "userId": Userdata.id,
      "status": "Processing",
      "planId": widget.PlanID,
      "installmentId": installmentID
    };
    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map s = jsonDecode(responseString);
      setState(() {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.size,
                alignment: Alignment.bottomCenter,
                child: Appointments()));
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
                          locale.COLLECTIONREQUESTPLACED,
                          style: black14BoldTextStyle,
                        )),
                        Center(
                            child: Text(
                          locale.SUCCESS,
                          style: black14MediumTextStyle,
                        )),
                        heightSpace,
                        Center(
                            child: Text(
                          DateTime.now().toString(),
                          style: black12MediumTextStyle,
                        )),
                        height20Space,
                        Center(
                          child: Container(
                            color: whiteColor,
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(otp),
                            )),
                          ),
                        ),
                        heightSpace,
                        Center(
                            child: Text(
                          locale.showcode,
                          style: black12MediumTextStyle,
                        )),
                        GestureDetector(
                            onTap: () {
                              Clipboard.setData(new ClipboardData(text: otp))
                                  .then((_) {
                                final snackBar =
                                    SnackBar(content: Text('OTP Copied!'));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                            child: Center(
                                child: Text(
                              locale.taptocopy,
                              style: black16MediumTextStyle,
                            )))
                      ],
                    ),
                  ),
                ));
      });
    } else {
      setState(() {
        showDialog(
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
                            child: Center(
                          child: Text(
                            locale.COLLECTIONREQUESTFAILED,
                            style: black16BoldTextStyle,
                          ),
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
      });
    }
  }

  final _formkey = GlobalKey<FormState>();
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
          key: _formkey,
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
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onEditingComplete: () {
                        checkPincode(PINcontroller.text);
                      },
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
                      controller: Landmarkcontroller,
                      validator: (value) =>
                          value.isEmpty ? "Field cannot be empty" : null,
                      keyboardType: TextInputType.streetAddress,
                      style: primaryColor16MediumTextStyle,
                      decoration: InputDecoration(
                        labelText: locale.LandMark,
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
                    if (_formkey.currentState.validate()) await addAddress();
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
