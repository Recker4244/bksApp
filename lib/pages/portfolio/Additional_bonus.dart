import 'dart:js';

import 'package:gold247/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:gold247/pages/currencyScreen/buy_gold.dart';

import 'package:page_transition/page_transition.dart';

class Additional_Bonus extends StatefulWidget {
  @override
  _Additional_BonusState createState() => _Additional_BonusState();
}

class _Additional_BonusState extends State<Additional_Bonus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: primaryColor,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'REFERRAL BONUS',
          style: primaryColor18BoldTextStyle,
        ),
      ),
      backgroundColor: scaffoldBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.all(30),
            height: 220,
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Approximate Total Bonus',
                  style: primaryColor18BoldTextStyle,
                ),
                Text(
                  '5.80 GRAM',
                  style: primaryColor16MediumTextStyle,
                ),
                height20Space,
                Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            'Total Joining Bonus',
                            style: white12MediumTextStyle,
                          ),
                          Text(
                            '5.80 GRAM',
                            style: white14MediumTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        '|',
                        style: white18MediumTextStyle,
                      ),
                      Column(
                        children: [
                          Text(
                            'Total Referral Bonus',
                            style: white12MediumTextStyle,
                          ),
                          Text(
                            '5.80 GRAM',
                            style: white14MediumTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Choice_Card1(
                'Surya Joined and Enroll in this plan', '1.08 GRAM', 'Click TO REMIND','SKIP PAYMENTS',context, BuyGold(),BuyGold(),
              ),
              Choice_Card1(
                'Prince Joined and Enroll in this plan', '2.18 GRAM', 'Click TO REMIND','SKIP PAYMENTS', context,BuyGold(),BuyGold(),
              ),
              Choice_Card1(
                'Agni Joined and Enroll in this plan', '1.95 GRAM', 'Click TO REMIND','SKIP PAYMENTS',context, BuyGold(),BuyGold(),
              ),
            ],
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            alignment: Alignment.center,
            color: primaryColor,
            padding: EdgeInsets.all(10),
            child: Text(
              'PROCEED',
              style: white18BoldTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Choice_Card1(
      String mainText,
      String amount,
      String bottomText1,
      String bottomText2,
      BuildContext context,

      Widget navigateTo1,
      Widget navigateTo2,

      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor,

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.size,
                        alignment: Alignment.bottomCenter,
                        child: navigateTo1));
              },
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(fixPadding * 1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  color: whiteColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage('assets/crypto_icon/btc.png'),
                          ),
                        ),
                        widthSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$mainText',
                              style: grey12BoldTextStyle,
                            ),
                            height5Space,
                            Text(
                              '$amount',
                              style: black16SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 27.0,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: navigateTo1));
                  },
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(fixPadding),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Text(
                      '$bottomText1'.toUpperCase(),
                      style: primaryColor16BoldTextStyle,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: navigateTo2));
                  },
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(fixPadding),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Text(
                      '$bottomText2'.toUpperCase(),
                      style: primaryColor16BoldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
