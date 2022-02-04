import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/language/locale.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:gold247/language/languageCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ButtonSate { init, loading, done }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class mobileNumber {
  String phoneNumber = '';
  bool whatsapp = true;
}

mobileNumber mobilenumber = mobileNumber();

class _LoginState extends State<Login> {
  Color colorofbox = Colors.transparent;
  ButtonSate state = ButtonSate.init;
  DateTime currentBackPressTime;
  String phoneIsoCode;
  final numberController = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  // void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
  //     String isoCode) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     phoneNumber = number;
  //     phoneIsoCode = isoCode;
  //     prefs.setString('phoneNumber', number);
  //   });
  // }
  @override
  void initState() {
    setState(() {
      colorofbox = Colors.transparent;
      isCorrect = false;
    });
    super.initState();
  }

  bool isCorrect = false;
  bool isAnimated = true;
  bool value = true;
  bool whatsapp = true;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final isDone = state == ButtonSate.done;
    final isStretch = isAnimated || state == ButtonSate.init;
    var locale = AppLocalizations.of(context);
    Widget buildCheckbox() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            activeColor: primaryColor,
            value: value,
            onChanged: (value) {
              setState(() {
                this.value = value;
                whatsapp = value;
              });
            },
          ),
          Text(
            locale.uncheck,
            style: black14RegularTextStyle,
          ),
        ],
      );
    }

    void Change_Language() async {
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
                              locale.Choose,
                              style: primaryColor18BoldTextStyle,
                            ),
                          ),
                          height20Space,
                          Container(
                            width: double.infinity,
                            height: 0.7,
                            color: greyColor.withOpacity(0.4),
                          ),

                          Hindi_or_English(),

                          height20Space,
                          // Buy Button
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
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
                                locale.continuebutton.toUpperCase(),
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

    MaterialStateProperty<Color> getColor(Color white, Color pressed) {
      final getColor = (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return pressed;
        } else
          return white;
      };
      return MaterialStateProperty.resolveWith(getColor);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: scaffoldBgColor,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 15.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Logo.png',
                width: 150,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5.h),
              Text(
                locale.signin,
                style: grey14BoldTextStyle,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  fixPadding * 3.0,
                  20,
                  fixPadding * 3.0,
                  15,
                ),
                child: Container(
                  width: 70.w,
                  // height: 8.h,
                  padding: EdgeInsets.only(left: fixPadding * 2.0),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: isCorrect ? colorofbox : colorofbox),
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        color: blackColor.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber);
                    },
                    inputDecoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none),
                    ),
                    validator: (String value) {
                      if (!value.startsWith("9") &&
                          !value.startsWith("8") &&
                          !value.startsWith("7") &&
                          !value.startsWith("6")) return 'Invalid Input';
                      return null;
                    },

                    maxLength: 10,
                    textStyle: TextStyle(),
                    onInputValidated: (bool value) {
                      setState(() {
                        isCorrect = value;
                        if (isCorrect) {
                          setState(() {
                            colorofbox = Colors.green;
                          });
                        } else {
                          setState(() {
                            colorofbox = Colors.red;
                          });
                        }
                      });
                      print(value);
                    },
                    spaceBetweenSelectorAndTextField: 0,
                    countries: ["IN"],
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    // autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: numberController,
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: OutlineInputBorder(),
                    onSaved: (PhoneNumber number) {
                      print('On Saved: $number');
                    },
                  ),
                ),
              ),
              buildCheckbox(),
              SizedBox(
                height: 2.h,
              ),
              ElevatedButton(
                  child: Text(
                    locale.continuebutton,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 1.h)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      foregroundColor: getColor(whiteColor, primaryColor),
                      backgroundColor: getColor(primaryColor, whiteColor)),
                  onPressed: () async {
                    HapticFeedback.vibrate();

                    if (isCorrect) {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: OTPScreen(),
                        ),
                      );
                      final PhoneNumberOb = numberController.text;
                      final PhoneReplace = PhoneNumberOb.replaceAll(" ", "");
                      http.Response response = await http.post(
                        Uri.parse("${baseurl}/api/auth/register"),
                        headers: {"Content-Type": "application/json"},
                        body: json.encode(
                            {"mobile": PhoneReplace, "isWhatsapp": whatsapp}),
                      );
                      print(response.body);
                      if (response.statusCode == 200) {
                        mobilenumber.phoneNumber = PhoneReplace;
                        mobilenumber.whatsapp = whatsapp;
                      }
                    }
                  }),
              SizedBox(
                height: 2.h,
              ),
              Text(
                locale.willSend,
                style: black14MediumTextStyle,
              ),
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                onTap: () {
                  if (isHindi)
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => GuestHome(
                          language: "Hindi",
                        ),
                      ),
                    );
                  else
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => GuestHome(
                          language: "English",
                        ),
                      ),
                    );
                },
                child: Text(
                  locale.guestLogin,
                  style: red16BoldTextStyle,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                onTap: () {
                  Change_Language();
                },
                child: Text(
                  locale.Choose,
                  style: red16BoldTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
      // onWillPop: () async {
      //   bool backStatus = onWillPop();
      //   if (backStatus) {
      //     exit(0);
      //   }
      //   return false;
      // },
      //),
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

bool isHindi = false;

class Hindi_or_English extends StatefulWidget {
  @override
  _Hindi_or_EnglishState createState() => _Hindi_or_EnglishState();
}

class _Hindi_or_EnglishState extends State<Hindi_or_English> {
  LanguageCubit _languageCubit;
  void setLanguage(bool set) {
    setState(() {
      isHindi = set;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isHindi = true;
                  });
                  _languageCubit.selectHindiLanguage();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 13,
                    decoration: BoxDecoration(
                      color: isHindi ? primaryColor : whiteColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              widthSpace,
              Text(
                locale.Hindi,
                style: primaryColor14MediumTextStyle,
              ),
            ],
          ),
          widthSpace,
          widthSpace,
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isHindi = false;
                  });
                  _languageCubit.selectEngLanguage();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 13,
                    decoration: BoxDecoration(
                      color: isHindi ? whiteColor : primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              widthSpace,
              Text(
                locale.English,
                style: primaryColor14MediumTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
