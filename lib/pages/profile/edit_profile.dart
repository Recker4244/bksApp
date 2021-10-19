import 'dart:async';

import 'package:gold247/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/pages/screens.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(Userdata.dob);
  final nameController = TextEditingController(text: Userdata.fname);
  final emailController = TextEditingController(text: Userdata.email);
  final dobController = TextEditingController();
  FocusNode nameControl = FocusNode();
  FocusNode emailControl = FocusNode();
  FocusNode dobControl = FocusNode();
  DateTime selectedDate = DateTime.now();
  String date = DateFormat("dd-MM-yyyy").format(DateTime.now());

  // editProfile() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final email = prefs.getString('Email') ?? "bksgold@bks.com";
  //   final username = prefs.getString('UserName') ?? "Unknown User";
  //   final dob = prefs.getString('DOB') ?? "00-00-0000";
  //   setState(() {
  //     nameController.text = username;
  //     emailController.text = email;
  //     dobController.text = dob;
  //   });
  // }

  Future updateUserDetail(String name, String email, String dob) async {
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
    if (name == "") {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'UserName Not Specified.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return FocusScope.of(context).requestFocus(nameControl);
    }
    if (email == "") {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'Email Not Specified.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return FocusScope.of(context).requestFocus(emailControl);
    }
    if (dob == "") {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'Date Of Birth Not Specified.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return FocusScope.of(context).requestFocus(dobControl);
    }
    http.Response response = await http.put(
      Uri.parse("https://goldv2.herokuapp.com/api/user/" + Userdata.sId),
      body: {"name": name, "email": email, "dob": dob},
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      Map datas = responseString;
      setState(() {
        Userdata = userdata.fromJson(datas);
      });
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'Changes Saved Successfully.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    setState(() {
      dobController.text = outputDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: primaryColor,
        title: Text(
          'Edit Profile',
          style: white16SemiBoldTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 160.0,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        width: width - fixPadding * 4.0,
                        alignment: Alignment.center,
                        child: Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70.0),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/user/default.jpeg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        child: Container(
                          width: width - fixPadding * 4.0,
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () => _selectOptionBottomSheet(),
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              width: 140.0,
                              padding: EdgeInsets.symmetric(
                                  vertical: fixPadding * 0.6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.orange,
                                border: Border.all(
                                  width: 2.0,
                                  color: whiteColor,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 16.0,
                                    color: whiteColor,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Change',
                                    style: white12MediumTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                heightSpace,

                // Name Field Start
                Container(
                  padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: primaryColor,
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: primaryColor,
                      ),
                    ),
                    child: TextField(
                      focusNode: nameControl,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      style: black14MediumTextStyle,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: black14MediumTextStyle,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: greyColor, width: 0.7),
                        ),
                      ),
                    ),
                  ),
                ),
                // Name Field End

                // Email Field Start
                Container(
                  padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: primaryColor,
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: primaryColor,
                      ),
                    ),
                    child: TextField(
                      focusNode: emailControl,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: black14MediumTextStyle,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: black14MediumTextStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor, width: 0.7),
                        ),
                      ),
                    ),
                  ),
                ),
                // Email Field End

                // Phone Number Field Start
                Container(
                  padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: primaryColor,
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: primaryColor,
                      ),
                    ),
                    child: TextField(
                      readOnly: true,
                      focusNode: dobControl,
                      controller: dobController,
                      keyboardType: TextInputType.number,
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
                        labelText: 'Date Of Birth',
                        labelStyle: black14MediumTextStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor, width: 0.7),
                        ),
                      ),
                    ),
                  ),
                ),
                // Phone Number Field End

                // Password Field Start
                // Container(
                //   padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                //   child: Theme(
                //     data: ThemeData(
                //       primaryColor: primaryColor,
                //       textSelectionTheme: TextSelectionThemeData(
                //         cursorColor: primaryColor,
                //       ),
                //     ),
                //     child: TextField(
                //       controller: passwordController,
                //       keyboardType: TextInputType.number,
                //       style: black14MediumTextStyle,
                //       decoration: InputDecoration(
                //         labelText: 'Password',
                //         labelStyle: black14MediumTextStyle,
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide(color: greyColor, width: 0.7),
                //         ),
                //       ),
                //       obscureText: true,
                //     ),
                //   ),
                // ),
                // Password Field End
                heightSpace,
                // Save Button Start
                InkWell(
                  onTap: () => updateUserDetail(nameController.text,
                      emailController.text, dobController.text),
                  borderRadius: BorderRadius.circular(7.0),
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(fixPadding * 1.5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Save',
                      style: white14BoldTextStyle,
                    ),
                  ),
                ),
                // Save Button End
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet for Select Options (Camera or Gallery) Start Here
  void _selectOptionBottomSheet() {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(fixPadding),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Choose Option',
                            textAlign: TextAlign.center,
                            style: black18BoldTextStyle,
                          ),
                        ),
                        heightSpace,
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: fixPadding),
                          width: width,
                          height: 1.0,
                          color: greyColor.withOpacity(0.5),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Camera', style: black14MediumTextStyle),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.photo_album,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Upload from Gallery',
                                  style: black14MediumTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
// Bottom Sheet for Select Options (Camera or Gallery) Ends Here
}
