import 'package:gold247/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/customSub.dart';
import 'package:gold247/models/standardSub.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/pages/bottom_bar.dart';
import 'package:gold247/pages/portfolio/total_balance.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/models/user.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Plan_Bonnus_Details extends StatefulWidget {
  final String byweight;
  final String byvalue;

  const Plan_Bonnus_Details({Key key, this.byweight, this.byvalue})
      : super(key: key);
  @override
  _Plan_Bonnus_DetailsState createState() => _Plan_Bonnus_DetailsState();
}

class _Plan_Bonnus_DetailsState extends State<Plan_Bonnus_Details> {
  List<subscription> temp;
  Future getplans() async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/subscription/user/${Userdata.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      List dat = det['data'];
      List<subscription> subs = [];
      for (int j = 0; j < dat.length; j++) {
        if (dat[j]['plan'] == null) {
          customSub sub = customSub.fromJson(dat[j]);
          subs.add(Custom(sub));
        } else {
          standardSub sub = standardSub.fromJson(dat[j]);
          subs.add(Standard(sub));
        }
      }
      temp = subs;
    } else {
      print(response.reasonPhrase);
    }

    return temp;
  }

  double compute(subscription cal) {
    double amount = 0;
    for (int i = 0; i < cal.installments().length; i++) {
      if (cal.installments()[i].status == "Saved" ||
          cal.installments()[i].status == "Released") {
        amount += double.parse(cal.installments()[i].gold.toString());
      } else
        amount -= double.parse(cal.installments()[i].gold.toString());
    }
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getplans(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: scaffoldBgColor,
                body: Center(
                    child: SpinKitRing(
                  duration: Duration(milliseconds: 700),
                  color: primaryColor,
                  size: 40.0,
                  lineWidth: 1.2,
                ))),
          );
        } else {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: whiteColor,
                centerTitle: true,
                title: Text(
                  'PLAN BONUS',
                  style: primaryColor18BoldTextStyle,
                ),
              ),
              backgroundColor: scaffoldBgColor,
              body: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(30),
                    height: 230,
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
                          '${(double.parse(widget.byweight) + double.parse(widget.byvalue)).toStringAsFixed(2)} GRAM',
                          style: primaryColor16MediumTextStyle,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        // Row(
                        //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'Weight',
                        //       style: black18MediumTextStyle,
                        //     ),
                        //     Spacer(),
                        //     Text(
                        //       'Value',
                        //       style: black18MediumTextStyle,
                        //     ),
                        //   ],
                        // ),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    'By Value',
                                    style: white12MediumTextStyle,
                                  ),
                                  Text(
                                    '${widget.byvalue} GRAM',
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
                                    'By Weight',
                                    style: white12MediumTextStyle,
                                  ),
                                  Text(
                                    '${widget.byweight} GRAM',
                                    style: white14MediumTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(20),
                        //   width: MediaQuery.of(context).size.width,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //       color: primaryColor,
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(20))),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: <Widget>[
                        //       Text(
                        //         '${widget.byweight} GRAM',
                        //         style: white18MediumTextStyle,
                        //       ),
                        //       Text(
                        //         '|',
                        //         style: white18MediumTextStyle,
                        //       ),
                        //       Text(
                        //         '${widget.byvalue} GRAM',
                        //         style: white18MediumTextStyle,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  (temp.isEmpty)
                      ? Positioned(
                          bottom: 100,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.size,
                                      alignment: Alignment.bottomCenter,
                                      child: BottomBar()));
                            },
                            child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Invest Now to earn additional bonus",
                                    style: white18MediumTextStyle,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ))
                      : Container(),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.size,
                                      alignment: Alignment.bottomCenter,
                                      child: TotalBalance(
                                        sub: temp[index],
                                        avail: compute(temp[index])
                                            .toStringAsFixed(2),
                                      )));
                            },
                            child: Choice_Card(
                                temp[index].planName(),
                                temp[index].planBonus().toStringAsFixed(2),
                                'Check Detail',
                                Icons.ac_unit));
                      },
                      itemCount: temp.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return errorScreen;
          }
        }
      },
    );
  }
}

Choice_Card(
  String mainText,
  String amount,
  String bottomText,
  IconData icons,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: whiteColor,
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 4.0,
        //     spreadRadius: 1.0,
        //     color: blackColor.withOpacity(0.05),
        //   ),
        // ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
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
                        width: 12.w,
                        height: 6.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: scaffoldBgColor,
                        ),
                        child: Icon(
                          icons,
                          color: primaryColor,
                          size: 8.w,
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
                            '$amount GRAM',
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
          InkWell(
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
                '$bottomText'.toUpperCase(),
                style: primaryColor16BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
