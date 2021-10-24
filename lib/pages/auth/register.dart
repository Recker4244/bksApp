import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/language/locale.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/models/user.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  String id;
  Register({this.id});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final panController = TextEditingController();
  final refferController = TextEditingController();
  final pan = TextEditingController();
  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
  register() async {
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
    if (nameController.text == "") {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'UserName Not Specified.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return FocusScope.of(context).requestFocus(firstFocusNode);
    }
    if (emailController.text == "") {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'Email Not Specified.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return FocusScope.of(context).requestFocus(secondFocusNode);
    }
    if (dobController.text == "") {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'Date Of Birth Not Specified.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return FocusScope.of(context).requestFocus(thirdFocusNode);
    }
    http.Response response = await http.put(
      Uri.parse("https://goldv2.herokuapp.com/api/user/" + widget.id),
      body: {
        "fname": nameController.text,
        "email": emailController.text,
        "dob": dobController.text,
        "refCode": refferController.text,
        "pan": pan.text,
      },
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      Map datas = responseString;
      setState(() {
        Userdata = userdata.fromJson(datas);
      });
      Navigator.push(context,
          PageTransition(type: PageTransitionType.fade, child: BottomBar()));
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                locale.register,
                style: grey14BoldTextStyle,
              ),
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
                  decoration: BoxDecoration(
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
                  child: TextField(
                    focusNode: firstFocusNode,
                    controller: nameController,
                    style: black14MediumTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: locale.username,
                      hintStyle: black14MediumTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ), //username
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
                  decoration: BoxDecoration(
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
                  child: TextField(
                    focusNode: secondFocusNode,
                    controller: emailController,
                    style: black14MediumTextStyle,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: locale.email,
                      hintStyle: black14MediumTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ), //Email
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
                  decoration: BoxDecoration(
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
                  child: TextField(
                    readOnly: true,
                    focusNode: thirdFocusNode,
                    controller: dobController,
                    style: black14MediumTextStyle,
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                          dobController.text =
                              new DateFormat("yyyy-MM-dd").format(picked);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: locale.DateOfBirth,
                      hintStyle: black14MediumTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
                  decoration: BoxDecoration(
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
                  child: TextField(
                    controller: pan,
                    style: black14MediumTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: locale.pan,
                      hintStyle: black14MediumTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ), //Password
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
                  decoration: BoxDecoration(
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
                  child: TextField(
                    controller: refferController,
                    style: black14MediumTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: locale.referalcode,
                      hintStyle: black14MediumTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ), //Referal ID
              SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: InkWell(
                  onTap: () => register(),
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      locale.continuebutton,
                      style: white14BoldTextStyle,
                    ),
                  ),
                ),
              ), //Continue
              heightSpace,
            ],
          ),
        ],
      ),
    );
  }
}
