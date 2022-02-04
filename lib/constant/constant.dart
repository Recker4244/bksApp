import 'package:flutter/material.dart';
import 'package:gold247/models/user.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

loadingDialog(BuildContext context) {
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
}

Future<String> getAccessToken() async {
  var headers = {
    'x-api-key': 'key_live_1XilWqECfePBMRzHKIfj4719kkc7q7C4',
    'x-api-secret': 'secret_live_x9NUTRidCJAidEDRj4JT9VyMwgcttZ2x',
    'x-api-version': '1.0'
  };
  var request =
      http.Request('POST', Uri.parse('https://api.sandbox.co.in/authenticate'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final responseString = await response.stream.bytesToString();
    Map det = jsonDecode(responseString);
    return det['access_token'];
  } else {
    print(response.reasonPhrase);
  }
}

Future<bool> verifyPan(String panno) async {
  var token = await getAccessToken();
  var headers = {
    'Authorization': token,
    'x-api-key': 'key_live_1XilWqECfePBMRzHKIfj4719kkc7q7C4',
    'x-api-version': '1.0'
  };
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.sandbox.co.in/pans/${panno}/verify?consent=Y&reason=Opening an account'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final responseString = jsonDecode(await response.stream.bytesToString());
    if (responseString['data']['full_name'] == Userdata.fname.toUpperCase()) {
      Userdata.pan = panno;
      await updateUserpan(panno);
      return true;
    } else
      return false;
  }
  return false;
}

Future updateUserpan(String panno) async {
  http.Response response = await http.put(
    Uri.parse("${baseurl}/api/user/" + Userdata.id),
    body: {
      "pan": panno,
    },
  );

  return;
}

Future<bool> pan(BuildContext context) async {
  TextEditingController pan = TextEditingController();
  if (Userdata.pan.isNotEmpty && Userdata.pan != null) return true;
  bool verified = false;
  await showDialog(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      size: 100.sp,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Enter your pan details for verification",
                      style: black14MediumTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: greyColor,
                      ),
                      child: TextFormField(
                        cursorColor: primaryColor,
                        controller: pan,
                        // keyboardType: TextInputType.number,
                        style: primaryColor16BoldTextStyle,
                        decoration: InputDecoration(
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                          fillColor: whiteColor,
                          labelText: "Enter your PAN no.",
                          labelStyle: primaryColor18BoldTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 0.7),
                          ),
                        ),
                        // InputDecoration(
                        //   focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: primaryColor, width: 2.0)),
                        //   labelText: locale.weight,
                        //   labelStyle: primaryColor18BoldTextStyle,
                        //   suffix: Text(
                        //     locale.GRAM,
                        //     style: primaryColor18BoldTextStyle,
                        //   ),
                        //   border: OutlineInputBorder(
                        //     borderSide:
                        //         BorderSide(color: greyColor, width: 0.7),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: InkWell(
                      onTap: () async {
                        loadingDialog(context);
                        bool verify = await verifyPan(pan.text);
                        print("Verifying pan");
                        Navigator.of(context).pop();
                        print("Status of verifying pan =$verified");
                        verified = verify;
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            "Verify",
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontSize: 14.0,
                              color: scaffoldBgColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
  return verified;
}

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

TextStyle khomePageHeading =
    TextStyle(color: primaryColor, fontSize: 8.sp, fontWeight: FontWeight.bold);

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
