import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/portfolio/Cart.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

double screenw;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login())));
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
        child:Image.asset(
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
