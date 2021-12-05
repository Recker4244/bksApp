import 'dart:async';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/main.dart';
import 'package:gold247/pages/auth/Strategy.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/language/locale.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/models/bankDetails.dart';
import 'package:gold247/pages/auth/login.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:sizer/sizer.dart';

var token;
enum ButtonSate1 { init, loading, done }

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with CodeAutoFill {
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  final thirdController = TextEditingController();
  final fourthController = TextEditingController();
  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();
  String appSignature;
  String otpCode;
  @override
  void codeUpdated() {
    setState(() {
      otpCode = code;
    });
    loadingDialog();
  }

  listenforotp() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  void initState() {
    super.initState();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
    listenForCode();
  }

  String _code = "";

  bool isAnimated = true;
  Future getuserdetails(String id) async {
    var request = http.Request('GET', Uri.parse('${baseurl}/api/user/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = json.decode(await response.stream.bytesToString());

      Userdata = userdata.fromJson(responseString);
    } else {
      print(response.reasonPhrase);
    }
  }

//Prince - To-Do
  loadingDialog() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     // return object of type Dialog
    //     return Dialog(
    //       elevation: 0.0,
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    //       child: Wrap(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.all(20.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: <Widget>[
    //                 SpinKitRing(
    //                   color: primaryColor,
    //                   size: 40.0,
    //                   lineWidth: 1.2,
    //                 ),
    //                 SizedBox(height: 25.0),
    //                 Text(
    //                   'Please Wait..',
    //                   style: grey14MediumTextStyle,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
    setState(() {
      state = ButtonSate1.loading;
    });
    var headers = {'Content-Type': 'application/json'};
    final body = {
      "mobile": int.parse(mobilenumber.phoneNumber),
      "otp": int.parse(firstController.text +
          secondController.text +
          thirdController.text +
          fourthController.text),
      "deviceToken": deviceToken
    };
    http.Response response = await http.post(
        Uri.parse("${baseurl}/api/auth/verify"),
        body: jsonEncode(body),
        headers: headers);
    //print(json.decode(response.body)['token']);
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);

      token = responseString['token'];

      if (responseString['user'] == null ||
          responseString['user']['email'] == "") {
        Timer(Duration(seconds: 3), () {
          setState(() {
            state = ButtonSate1.done;
          });
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: Register(id: responseString['user']['id'])));
        });
      } else {
        await getuserdetails(responseString['user']['id']);
        if (Userdata.isInvested) {
          Timer(Duration(seconds: 3), () {
            setState(() {
              state = ButtonSate1.done;
            });
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: BottomBar(
                      index: 2,
                    )));
          });
        } else {
          Timer(
              Duration(seconds: 3),
              () => Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: BottomBar())));
        }
      }
    } else if (response.statusCode == 400) {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'Invalid OTP Entered.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      setState(() {
        firstController.text = "";
        secondController.text = "";
        thirdController.text = "";
        fourthController.text = "";
        FocusScope.of(context).requestFocus(firstFocusNode);
      });
    }
  }

  otpCheck() async {
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
    http.Response response = await http.post(
      Uri.parse("${baseurl}/api/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "mobile": mobilenumber.phoneNumber,
        "isWhatsapp": mobilenumber.whatsapp
      }),
    );
    if (response.statusCode == 200) {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'OTP Has Been Sent.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
    } else
      Fluttertoast.showToast(
        msg: 'Invalid OTP entered',
        backgroundColor: Colors.black,
        textColor: Colors.red,
      );
  }

  MaterialStateProperty<Color> getColor(Color white, Color pressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return pressed;
      } else
        return white;
    };
    return MaterialStateProperty.resolveWith(getColor);
  }

  ButtonSate1 state = ButtonSate1.init;
  @override
  Widget build(BuildContext context) {
    final isDone = state == ButtonSate1.done;
    final isStretch = isAnimated || state == ButtonSate1.init;
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: blackColor,
                ),
              )
            ],
          ),
          SizedBox(height: 70.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Logo.png',
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Text(
                  locale.enterOTP,
                  style: grey14BoldTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50.0),
              // TextFieldPinAutoFill(
              //   codeLength: 4,
              //   currentCode: _code,
              // ),
              // OTP Box Start
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // 1 Start
                    Container(
                      width: 50.0,
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: blackColor.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: TextField(
                        focusNode: firstFocusNode,
                        controller: firstController,
                        style: black14MediumTextStyle,
                        keyboardType: TextInputType.number,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(18.0),
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (v) {
                          FocusScope.of(context).requestFocus(secondFocusNode);
                        },
                      ),
                    ),
                    // 1 End
                    // 2 Start
                    Container(
                      width: 50.0,
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: blackColor.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: TextField(
                        focusNode: secondFocusNode,
                        controller: secondController,
                        style: black14MediumTextStyle,
                        keyboardType: TextInputType.number,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(18.0),
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (v) {
                          FocusScope.of(context).requestFocus(thirdFocusNode);
                        },
                      ),
                    ),
                    // 2 End
                    // 3 Start
                    Container(
                      width: 50.0,
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: blackColor.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: TextField(
                        focusNode: thirdFocusNode,
                        controller: thirdController,
                        style: black14MediumTextStyle,
                        keyboardType: TextInputType.number,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(18.0),
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (v) {
                          FocusScope.of(context).requestFocus(fourthFocusNode);
                        },
                      ),
                    ),
                    // 3 End
                    // 4 Start
                    Container(
                      width: 50.0,
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: blackColor.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: TextField(
                        focusNode: fourthFocusNode,
                        controller: fourthController,
                        style: black14MediumTextStyle,
                        keyboardType: TextInputType.number,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(18.0),
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (v) {
                          fourthFocusNode.unfocus();
                          loadingDialog();
                        },
                      ),
                    ),
                    // 4 End
                  ],
                ),
              ),
              // OTP Box End

              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () => otpCheck(),
                      child: Text(
                        locale.resend,
                        style: black18BoldTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              height20Space,
              // ElevatedButton(
              //     style: ButtonStyle(
              //         foregroundColor: getColor(whiteColor, primaryColor),
              //         backgroundColor: getColor(primaryColor, whiteColor)),
              //     onPressed: () {
              //       loadingDialog();
              //     },
              //     child: Text(
              //       locale.continuebutton,
              //       style: white14BoldTextStyle,
              //     )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: InkWell(
                  onTap: () {
                    loadingDialog();
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: state == ButtonSate1.init
                          ? MediaQuery.of(context).size.width
                          : 60,
                      curve: Curves.easeIn,
                      onEnd: () {
                        setState(() {
                          isAnimated = !isAnimated;
                        });
                      },
                      child: isStretch
                          ? buildButton(locale)
                          : buildSmallButton(isDone)),
                ),
              ),
              height20Space,
            ],
          ),
        ],
      ),
    );
  }

  Container buildButton(AppLocalizations locale) {
    return Container(
      width: double.infinity,
      height: 6.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: primaryColor,
      ),
      child: FittedBox(
        child: Text(
          locale.continuebutton,
          style: white18BoldTextStyle,
        ),
      ),
    );
  }

  Widget buildSmallButton(bool isDone) {
    return Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
        child: Center(
          child: isDone
              ? Icon(Icons.done, size: 52, color: scaffoldBgColor)
              : CircularProgressIndicator(
                  color: scaffoldBgColor,
                ),
        ));
  }
}
