import 'dart:async';
import 'dart:io';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({Key key}) : super(key: key);

  @override
  _EnterPinScreenState createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  DateTime currentBackPressTime;
  int pin1, pin2, pin3, pin4;
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: WillPopScope(
        child: SafeArea(
          child: Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(fixPadding * 2.0),
                      width: width,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Need Help?'.toUpperCase(),
                          style: primaryColor14MediumTextStyle,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/Logo.png',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                    height20Space,
                    heightSpace,
                    Text(
                      'Enter your PIN',
                      style: black16MediumTextStyle,
                    ),
                    height5Space,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: fixPadding * 4.0),
                      child: Text(
                        'Enter the secure PIN to access your account.',
                        style: grey14RegularTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                // Pin point start
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        pinRoundedItem(pin1),
                        widthSpace,
                        pinRoundedItem(pin2),
                        widthSpace,
                        pinRoundedItem(pin3),
                        widthSpace,
                        pinRoundedItem(pin4),
                      ],
                    ),
                    height20Space,
                    heightSpace,
                    (progress)
                        ? SpinKitRing(
                      color: primaryColor,
                      size: 20.0,
                      lineWidth: 1.5,
                    )
                        : InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot PIN?',
                        style: primaryColor14RegularTextStyle,
                      ),
                    ),
                  ],
                ),
                // Pin point end

                // KeyPad Start
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        keyPadButton(1),
                        verticalLine(),
                        keyPadButton(2),
                        verticalLine(),
                        keyPadButton(3),
                      ],
                    ),
                    horizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        keyPadButton(4),
                        verticalLine(),
                        keyPadButton(5),
                        verticalLine(),
                        keyPadButton(6),
                      ],
                    ),
                    horizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        keyPadButton(7),
                        verticalLine(),
                        keyPadButton(8),
                        verticalLine(),
                        keyPadButton(9),
                      ],
                    ),
                    horizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (width - 2.0) / 3,
                          height: 30.0,
                          alignment: Alignment.center,
                        ),
                        verticalLine(),
                        keyPadButton(0),
                        verticalLine(),
                        InkWell(
                          onTap: () {
                            if (progress) {
                            } else {
                              if (pin4 != null) {
                                setState(() {
                                  pin4 = null;
                                });
                              } else if (pin3 != null) {
                                setState(() {
                                  pin3 = null;
                                });
                              } else if (pin2 != null) {
                                setState(() {
                                  pin2 = null;
                                });
                              } else if (pin1 != null) {
                                setState(() {
                                  pin1 = null;
                                });
                              } else {}
                            }
                          },
                          child: Container(
                            width: (width - 2.0) / 3,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.backspace,
                              color: blackColor,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // KeyPad End
              ],
            ),
          ),
        ),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  pinRoundedItem(pin) {
    return Container(
      width: 22.0,
      height: 22.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        border: Border.all(
          width: 1.5,
          color: (pin == null) ? greyColor : blackColor,
        ),
        color: (pin == null) ? Colors.transparent : blackColor,
      ),
    );
  }

  horizontalLine() {
    return Container(
      height: 1.0,
      width: double.infinity,
      color: greyColor.withOpacity(0.25),
    );
  }

  verticalLine() {
    return Container(
      height: 50.0,
      width: 1.0,
      color: greyColor.withOpacity(0.25),
    );
  }

  keyPadButton(number) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        if (progress) {
        } else {
          if (pin1 == null) {
            setState(() {
              pin1 = number;
            });
          } else if (pin2 == null) {
            setState(() {
              pin2 = number;
            });
          } else if (pin3 == null) {
            setState(() {
              pin3 = number;
            });
          } else if (pin4 == null) {
            setState(() {
              pin4 = number;
              progress = true;
              Timer(
                  Duration(seconds: 3),
                      () => Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 600),
                          type: PageTransitionType.fade,
                          child: BottomBar())));
            });
          } else {}
        }
      },
      child: Container(
        width: (width - 2.0) / 3,
        height: 50.0,
        alignment: Alignment.center,
        child: Text(
          '$number',
          style: black18MediumTextStyle,
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
