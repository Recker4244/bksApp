import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/AddressDetail.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/portfolio/Cart.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

double screenw;
AudioPlayer player = AudioPlayer();
playSound() {
  player.play();
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
    // player.setAsset("assets/audio/splash.mp3");
    // playSound();
  }

  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn');

    if (status != null && status == true) {
      token = prefs.getString('token');

      final userMap = jsonDecode(prefs.getString('user'));

      Userdata = userdata.fromJson(userMap);

      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => BottomBar(),
        ),
      );
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Container(
        width: width,
        height: height,
        child: Image.asset(
          'assets/gif_file/GIF_Med.gif',
          width: 70.w,
          height: 25.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//Your work ends here****************************************
