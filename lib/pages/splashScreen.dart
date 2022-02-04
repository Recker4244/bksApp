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
import 'package:http/http.dart' as http;

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

    player.setAsset("assets/audio/splash.mp3");
    playSound();
    Future.delayed(Duration(seconds: 5), () {
      getUserDetails();
      // Do something
    });
  }

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

  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn');
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Login()));
    if (status != null && status == true) {
      token = prefs.getString('token');

      final userMap = jsonDecode(prefs.getString('user'));

      await getuserdetails(userMap['id']);
      //Userdata = userdata.fromJson(userMap);

      if (Userdata.isInvested)
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => BottomBar(
              index: 2,
            ),
          ),
        );
      else
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => BottomBar(
              index: 1,
            ),
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
