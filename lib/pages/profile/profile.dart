import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/Eshop/COD_address.dart';
import 'package:gold247/pages/portfolio/Transactions.dart';
import 'package:gold247/pages/profile/Addressdetails.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/models/user.dart';
import 'Orders.dart';
import 'package:gold247/pages/portfolio/Appointments.dart';
import 'package:gold247/pages/portfolio/Collections.dart';
import 'dart:convert';
import 'package:gold247/language/locale.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  logout() async {
    Userdata = userdata();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", false);
    prefs.clear();
  }

  logoutDialog() {
    logout();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        double width = MediaQuery.of(context).size.width;
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You sure want to logout?',
                      style: black16BoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: (width - fixPadding * 14.0) / 2,
                            padding: EdgeInsets.symmetric(vertical: fixPadding),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1.0,
                                color: primaryColor,
                              ),
                              color: whiteColor,
                            ),
                            child: Text(
                              'Cancel',
                              style: black14MediumTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Login())),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: (width - fixPadding * 14.0) / 2,
                            padding: EdgeInsets.symmetric(vertical: fixPadding),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'Logout',
                              style: white14MediumTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    aboutUser() {
      if (Userdata.pan == '' || Userdata.pan == null) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image(
                          image: Userdata.image == null
                              ? AssetImage(
                                  'assets/user/default.jpeg',
                                )
                              : NetworkImage(Userdata.image),
                          width: 20.w,
                        )),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: redColor,
                          border: Border.all(
                            width: 2.0,
                            color: whiteColor,
                          ),
                        ),
                        child: Icon(
                          Icons.gpp_bad,
                          size: 25.0,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace,
              InkWell(
                child: Text(
                  'KYC Not Verified',
                  style: red14MediumTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Support(),
                    ),
                  );
                },
              ),
              heightSpace,
              Text(
                Userdata.fname,
                style: black18SemiBoldTextStyle,
              ),
              height5Space,
              Text(
                Userdata.mobile.toString(),
                style: grey16MediumTextStyle,
              ),
            ],
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        'assets/user/default.jpeg',
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: greenColor,
                          border: Border.all(
                            width: 2.0,
                            color: whiteColor,
                          ),
                        ),
                        child: Icon(
                          Icons.gpp_good,
                          size: 25.0,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace,
              Text(
                locale.KYCVerified,
                style: green14MediumTextStyle,
              ),
              heightSpace,
              Text(
                Userdata.fname,
                style: black18SemiBoldTextStyle,
              ),
              height5Space,
              Text(
                Userdata.mobile.toString(),
                style: grey16MediumTextStyle,
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            aboutUser(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: EditProfile(),
                  ),
                ).then((value) {
                  setState(() {});
                });
              },
              child: profileItem(
                  Icons.person, locale.editProfile, locale.edityourProfile),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: BankDetails(),
                  ),
                );
              },
              child: profileItem(
                  Icons.account_balance, locale.BankDetails, locale.HereBank),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: AddressDetails(),
                  ),
                );
              },
              child: profileItem(FontAwesomeIcons.addressBook,
                  locale.AddressDetails, locale.hereAddress),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Portfolio(),
                  ),
                );
              },
              child: profileItem(FontAwesomeIcons.piggyBank, locale.Portfolio,
                  locale.herePortfolio),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: TransactionScreen(),
                  ),
                );
              },
              child: profileItem(Icons.receipt_long, locale.Transactions,
                  locale.HereTransaction),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Orders(),
                  ),
                );
              },
              child: profileItem(
                  FontAwesomeIcons.boxOpen, locale.Orders, locale.hereOrders),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Collections(),
                  ),
                );
              },
              child: profileItem(FontAwesomeIcons.handHoldingUsd,
                  locale.collections, locale.hereCollections),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Appointments(),
                  ),
                );
              },
              child: profileItem(FontAwesomeIcons.calendarCheck,
                  locale.Appointments, locale.hereAppointments),
            ),
            heightSpace,
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: PrivacyPolicy(),
                  ),
                );
              },
              child: profileItem(Icons.note, locale.Terms, locale.hereTerms),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: PrivacyPolicy(),
                  ),
                );
              },
              child:
                  profileItem(Icons.note, locale.Privacy, locale.herePrivacy),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: PrivacyPolicy(),
                  ),
                );
              },
              child: profileItem(
                  Icons.note, locale.returnPolicy, locale.hereReturn),
            ),
            divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Support(),
                  ),
                );
              },
              child: profileItem(
                  Icons.headset_mic, locale.Helpsupport, locale.hereHelp),
            ),
            divider(),
            InkWell(
              onTap: () {},
              child: profileItem(
                  Icons.star_border, locale.RateUs, locale.hereRate),
            ),
            heightSpace,
            InkWell(
              onTap: () {},
              child: profileItem(Icons.android, 'About MyGold', 'v1.0.0'),
            ),
            heightSpace,

            // Logout
            InkWell(
              onTap: () => logoutDialog(),
              child: Container(
                padding: EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.5,
                    fixPadding * 2.0, fixPadding * 1.5),
                color: whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      size: 28.0,
                      color: blackColor,
                    ),
                    width20Space,
                    Text(
                      locale.logout,
                      style: red16MediumTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            height20Space,
          ],
        ),
      ),
    );
  }

  profileItem(icon, title, subtitle) {
    return Container(
      padding: EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.5,
          fixPadding * 2.0, fixPadding * 1.5),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28.0,
            color: blackColor,
          ),
          width20Space,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: black16MediumTextStyle,
                ),
                SizedBox(height: 3.0),
                Text(
                  subtitle,
                  style: grey14RegularTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      width: double.infinity,
      height: 0.7,
      color: greyColor.withOpacity(0.15),
    );
  }
}
