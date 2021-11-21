import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const Color scaffoldLightColor = const Color(0xFFFFF1E0);
const Color primaryColor = const Color(0xFF95203D);
const Color whiteColor = const Color(0xFFFEF8F0);
const Color blackColor = Colors.black;
const Color greyColor = const Color(0xFF8F8F8F);
const Color redColor = const Color(0xFFFF0000);
const Color orangeColor = const Color(0xFFFFA500);
const Color greenColor = const Color(0xFF006400);
const Color scaffoldBgColor = const Color(0xFFFFECCF);
const String baseurl = "http://13.59.57.74:5000";
const String patch = "13.59.57.74:5000";
const double fixPadding = 10.0;
var errorScreen = SafeArea(
    child: Scaffold(
        backgroundColor: scaffoldBgColor,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " There seems to be an error connecting to the server",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ))));
const SizedBox heightSpace = const SizedBox(height: 10.0);

const SizedBox height5Space = const SizedBox(height: 5.0);

const SizedBox height20Space = const SizedBox(height: 20.0);

const SizedBox widthSpace = const SizedBox(width: 10.0);
const SizedBox divider = const SizedBox(
  width: double.infinity,
  child: Divider(
    thickness: 1,
    color: primaryColor,
  ),
);

const SizedBox width5Space = const SizedBox(width: 5.0);

const SizedBox width20Space = const SizedBox(width: 20.0);

const TextStyle appBarTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: blackColor,
);

const TextStyle appBarWhiteTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: whiteColor,
);

const TextStyle black12RegularTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: blackColor,
);

const TextStyle black14RegularTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: blackColor,
);

const TextStyle black16RegularTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: blackColor,
);

const TextStyle black14BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black12MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black14MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black16MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black18MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black14SemiBoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

const TextStyle black16SemiBoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

const TextStyle black18SemiBoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

const TextStyle black16BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black18BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black22BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 22.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white12MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white14MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white16MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white18MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white48MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 48.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white12SemiBoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

const TextStyle white16SemiBoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

const TextStyle white14BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white16BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);
const TextStyle gold16BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: orangeColor,
  fontWeight: FontWeight.bold,
);
const TextStyle white18BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white26BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 26.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white36BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 36.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white44BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 44.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle primaryColor12RegularTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: primaryColor,
);

const TextStyle primaryColor14RegularTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: primaryColor,
);

const TextStyle primaryColor14MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

const TextStyle primaryColor16MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

const TextStyle primaryColor16BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

const TextStyle primaryColor18BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

const TextStyle primaryColor22BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 22.0,
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey12RegularTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: greyColor,
);

const TextStyle grey14RegularTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: greyColor,
);

const TextStyle grey12MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: greyColor,
  fontWeight: FontWeight.w500,
);

const TextStyle grey12MediumItalicTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: greyColor,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.italic,
);

const TextStyle grey14MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: greyColor,
  fontWeight: FontWeight.w500,
);

const TextStyle grey16MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: greyColor,
  fontWeight: FontWeight.w500,
);

const TextStyle grey12BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey14BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey16BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey18BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 18.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey20BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 20.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle green14MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: greenColor,
  fontWeight: FontWeight.w500,
);

const TextStyle red14MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 14.0,
  color: redColor,
  fontWeight: FontWeight.w500,
);

const TextStyle red16MediumTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: redColor,
  fontWeight: FontWeight.w500,
);

const TextStyle red16BoldTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 16.0,
  color: redColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black12LightTextStyle = const TextStyle(
  fontFamily: 'Jost',
  fontSize: 12.0,
  color: blackColor,
  fontWeight: FontWeight.normal,
);

String goldIngotsPath = 'assets/crypto_icon/gold_ingots.png';
