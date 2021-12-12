import 'dart:io';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/Eshop/Collections.dart';
import 'package:gold247/pages/Eshop/ItemsCat.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/pages/Eshop/eshop.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

class BottomBar extends StatefulWidget {
  final int index;

  const BottomBar({Key key, this.index}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  DateTime currentBackPressTime;
  GlobalKey keyBottomNavigation1 = GlobalKey();
  GlobalKey keyBottomNavigation2 = GlobalKey();
  GlobalKey keyBottomNavigation3 = GlobalKey();
  GlobalKey keyBottomNavigation4 = GlobalKey();
  int currentIndex;
  @override
  checkFirstTime() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // initScreen = preferences.getInt('initScreen');
    // await preferences.setInt(
    //     'initScreen', 1); //already we have launch app return 1
    // initScreen == 0 || initScreen == null
    //     ? null
    //     : Future.delayed(Duration(seconds: 2), showTutorial);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    if (firstTime != null && !firstTime) {
    } else {
      prefs.setBool('first_time', true);
      Future.delayed(Duration(seconds: 2), showTutorial);
    }
  }

  void initState() {
    checkFirstTime();

    super.initState();

    if (widget.index != null) {
      setState(() {
        currentIndex = widget.index;
      });
    } else {
      setState(() {
        currentIndex = 1;
      });
    }
  }

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  void showTutorial() async {
    targets = await initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "Skip",
      paddingFocus: 20,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onSkip: () {
        print("skip");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(color: Colors.amber),
          //   height: 8.h,
          //   child: Row(
          //     children: [
          //       Expanded(
          //           flex: 1,
          //           child: Center(
          //             child: SizedBox(
          //               key: keyBottomNavigation1,
          //             ),
          //           )),
          //       Expanded(
          //           flex: 1,
          //           child: Center(
          //             child: SizedBox(
          //               key: keyBottomNavigation2,
          //             ),
          //           )),
          //       Expanded(
          //         flex: 1,
          //         child: Center(
          //           child: SizedBox(
          //             key: keyBottomNavigation3,
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: Center(
          //           child: SizedBox(
          //             key: keyBottomNavigation4,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Material(
            elevation: 3.0,
            child: Container(
              height: 8.h,
              width: double.infinity,
              color: whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  bottomBarItem(FontAwesomeIcons.home,
                      'assets/icon/grey/user.png', 1, keyBottomNavigation1),
                  bottomBarItem(FontAwesomeIcons.piggyBank,
                      'assets/icon/grey/user.png', 2, keyBottomNavigation2),
                  bottomBarItem(FontAwesomeIcons.store,
                      'assets/icon/grey/user.png', 3, keyBottomNavigation3),
                  bottomBarItem(FontAwesomeIcons.user,
                      'assets/icon/grey/user.png', 4, keyBottomNavigation4),
                ],
              ),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        child: (currentIndex == 1)
            ? Home()
            : (currentIndex == 2)
                ? Portfolio()
                : (currentIndex == 3)
                    ? ItemsCat()
                    : Profile(),
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

  bottomBarItem(icon, nonActiveIconPath, index, Key k) {
    return InkWell(
      key: k,
      onTap: () => changeIndex(index),
      child: Padding(
        padding: const EdgeInsets.all(fixPadding * 0.6),
        child: Icon(
          icon,
          color: (index == currentIndex) ? primaryColor : greyColor,
          size: 8.w,
        ),
      ),
    );
  }

  Future<List<TargetFocus>> initTargets() async {
    targets.clear();

    // targets.add(
    //   TargetFocus(
    //     identify: "keyBottomNavigation1",
    //     keyTarget: keyBottomNavigation1,
    //     alignSkip: Alignment.topRight,
    //     contents: [
    //       TargetContent(
    //         align: ContentAlign.top,
    //         builder: (context, controller) {
    //           return Container(
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   "Here you can Buy and save for your future",
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
    targets.add(
      TargetFocus(
        paddingFocus: 3,
        identify: "keyBottomNavigation1",
        keyTarget: keyBottomNavigation1,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Here you can Buy and Save for your future",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        paddingFocus: 3,
        identify: "keyBottomNavigation2",
        keyTarget: keyBottomNavigation2,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Here you can check all your savings",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        paddingFocus: 3,
        identify: "keyBottomNavigation3",
        keyTarget: keyBottomNavigation3,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Here you can buy our best jewellery",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        paddingFocus: 3,
        identify: "keyBottomNavigation4",
        keyTarget: keyBottomNavigation4,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "All the system settings,profiles and orders you can find here",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }
}
