import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class Referal_Bonus_Detials extends StatefulWidget {
  @override
  _Referal_Bonus_DetialsState createState() => _Referal_Bonus_DetialsState();
}

class _Referal_Bonus_DetialsState extends State<Referal_Bonus_Detials> {
  List<referral> temp;
  double totalbonus = 0.0;
  Future getreferrals(String referralId) async {
    totalbonus = 0.0;
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/referral?refereedBy=${referralId}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      temp = List<referral>.from(l.map((model) => referral.fromJson(model)));
      for (int i = 0; i < temp.length; i++) {
        totalbonus += double.parse(temp[i].bonus);
      }
      print(totalbonus);
    } else {
      print(response.reasonPhrase);
    }
    return temp;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getreferrals(Userdata.refCode),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
              child: Scaffold(
                  backgroundColor: scaffoldBgColor,
                  body: Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ))),
            );
          } else {
            if (snapshot.hasData) {
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
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(30),
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
                                '${(Userdata.joiningBonus + 5.80).toStringAsFixed(2)} GRAM',
                                style: primaryColor16MediumTextStyle,
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          'Total Joining Bonus',
                                          style: white12MediumTextStyle,
                                        ),
                                        Text(
                                          Userdata.joiningBonus
                                              .toStringAsFixed(2),
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
                        Expanded(
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Choice_Card1(
                              '${temp[index].user.fname} Joined and Enroll in this plan',
                              '${temp[index].bonus} GRAM',
                              'Click TO REMIND',
                              'MATURE BY:- 14-08-2021',
                            );
                          },
                          itemCount: temp.length,
                        ))
                      ]));
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         width: MediaQuery.of(context).size.width,
              //         alignment: Alignment.center,
              //         color: primaryColor,
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //           'PROCEED',
              //           style: white18BoldTextStyle,
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            } else {
              return SafeArea(
                  child: Scaffold(
                      backgroundColor: scaffoldBgColor,
                      body: Text(" Oops !! No data ")));
            }
          }
        });
  }
}

Choice_Card1(
  String mainText,
  String amount,
  String bottomText1,
  String bottomText2,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
        fixPadding * 1.5, fixPadding * 1.5, fixPadding * 1.5, 0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                      width: 12.w,
                      height: 6.h,
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/crypto_icon/btc.png'),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$mainText',
                          style: grey12BoldTextStyle,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
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
                  size: 5.w,
                  color: primaryColor,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
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
                  style: primaryColor14MediumTextStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.all(fixPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                  ),
                  color: Colors.white,
                ),
                child: Text('$bottomText2'.toUpperCase(),
                    style: primaryColor14MediumTextStyle),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
