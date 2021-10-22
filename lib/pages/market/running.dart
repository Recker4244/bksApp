import 'package:http/http.dart' as http;

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:gold247/pages/portfolio/Buy_Plan.dart';
import 'dart:convert';
import 'package:gold247/language/locale.dart';

class Running extends StatefulWidget {
  final List<subscription> running;
  const Running({Key key, this.running}) : super(key: key);

  @override
  _RunningState createState() => _RunningState();
}

class _RunningState extends State<Running> {
  double compute(subscription cal) {
    double amount = 0;
    for (int i = 0; i < cal.installments.length; i++) {
      if (cal.installments[i].status == "Saved" ||
          cal.installments[i].status == "Released") {
        amount += double.parse(cal.installments[i].gold.toString());
      } else
        amount -= double.parse(cal.installments[i].gold.toString());
    }
    return amount;
  }

  skip(String id) async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/subscription/skip/${id}/${Userdata.sId}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.running.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        double gold = compute(widget.running[index]);
        final item = widget.running[index];
        return Padding(
          padding: (index != widget.running.length - 1)
              ? EdgeInsets.fromLTRB(
                  fixPadding * 1.5, fixPadding * 1.5, fixPadding * 1.5, 0.0)
              : EdgeInsets.all(fixPadding * 1.5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.size,
                      alignment: Alignment.center,
                      child: TotalBalance(
                        sub: widget.running[index],
                        avail: gold.toStringAsFixed(2),
                      )));
            },
            child: Container(
              height: 138,
              width: 100,
              decoration: BoxDecoration(
                color: scaffoldBgColor,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          widthSpace,
                          Image.asset(
                            "assets/crypto_icon/gold_ingots.png",
                            height: 44,
                            width: 44,
                            fit: BoxFit.cover,
                          ),
                          widthSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total Gold Saved in this Plan",
                                style: grey14BoldTextStyle,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${gold.toStringAsFixed(2)} GRAM",
                                style: black16BoldTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: primaryColor,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.size,
                                      alignment: Alignment.bottomCenter,
                                      child: Deposit(
                                          balance: gold.toStringAsFixed(2))));
                            },
                            child: Text(
                              "BUY GOLD",
                              style: black14BoldTextStyle,
                            ),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              if (widget.running[index].skipCount == 2 ||
                                  widget.running[index].unpaidSkips == 1) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog

                                    return Dialog(
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Wrap(
                                        children: [
                                          Container(
                                            color: scaffoldBgColor,
                                            padding: EdgeInsets.all(
                                                fixPadding * 2.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width: double.infinity,
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: Icon(
                                                      Icons.close_sharp,
                                                      color: primaryColor,
                                                      size: 35.0,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.warning,
                                                  size: 50.0,
                                                  color: redColor,
                                                ),
                                                SizedBox(
                                                  height: 13,
                                                ),
                                                Text(
                                                  "Your plan will be forfeited"
                                                      .toUpperCase(),
                                                  style: black16MediumTextStyle,
                                                ),
                                                // heightSpace,
                                                // SizedBox(height: 5),
                                                Text(
                                                  "crossed maximum unpaid skips"
                                                      .toUpperCase(),
                                                  style: black16MediumTextStyle,
                                                ),
                                                SizedBox(height: 13),
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      // depositWithdrawalItem('Total Saved', '15.80 GRAM'),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(17),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "BONUS LOSS",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Jost',
                                                                fontSize: 12.0,
                                                                color:
                                                                    scaffoldBgColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            height5Space,
                                                            Text(
                                                              "${gold.toStringAsFixed(2)} GRAM",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Jost',
                                                                fontSize: 18.0,
                                                                color:
                                                                    scaffoldBgColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 60.0,
                                                        width: 0.7,
                                                        color: whiteColor,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            "HANDLING CHARGES",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Jost',
                                                              fontSize: 12.0,
                                                              color:
                                                                  scaffoldBgColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          height5Space,
                                                          Text(
                                                            "${(2.0 * gold).toStringAsFixed(2)} INR",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Jost',
                                                              fontSize: 18.0,
                                                              color:
                                                                  scaffoldBgColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // depositWithdrawalItem('Bonus Earned', '1.80 GRAM'),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 13.0),
                                                Text(
                                                  'Still wish to proceed?',
                                                  style: grey14BoldTextStyle,
                                                ),
                                                SizedBox(height: 13.0),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  child: InkWell(
                                                    onTap: () {
                                                      skip(widget
                                                          .running[index].sId);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Center(
                                                        child: Text(
                                                          "PROCEED TO SKIP",
                                                          style: TextStyle(
                                                            fontFamily: 'Jost',
                                                            fontSize: 14.0,
                                                            color:
                                                                scaffoldBgColor,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          backgroundColor: scaffoldBgColor,
                                          title: Center(
                                            child: CircleAvatar(
                                              radius: 20.0,
                                              backgroundColor: Colors.green,
                                              child: Icon(
                                                Icons.check,
                                                size: 30.0,
                                                color: scaffoldBgColor,
                                              ),
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Center(
                                                    child: Text(
                                                  "0.1 GRAM ON HOLD",
                                                  style: black14BoldTextStyle,
                                                )),
                                                Center(
                                                    child: Text(
                                                  'SUCCESS',
                                                  style: black14MediumTextStyle,
                                                )),
                                                heightSpace,
                                                Center(
                                                    child: Text(
                                                  DateTime.now().toString(),
                                                  style: black12MediumTextStyle,
                                                )),
                                                Center(
                                                  child: Container(
                                                    color: whiteColor,
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Center(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "You have 27 days left to pay"),
                                                    )),
                                                  ),
                                                ),
                                                height20Space,
                                                Center(
                                                    child: Text(
                                                  "Pay before your new cycle starts",
                                                  style: black12MediumTextStyle,
                                                )),
                                                heightSpace,
                                                Center(
                                                    child: Text(
                                                  'Show this code while you visit Store',
                                                  style: black12MediumTextStyle,
                                                ))
                                              ],
                                            ),
                                          ),
                                        ));
                              }
                            },
                            child: Text(
                              "SKIP",
                              style: black14BoldTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
