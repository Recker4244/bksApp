import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/customSub.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/standardSub.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/pages/currencyScreen/buy_gold.dart';
import 'package:gold247/pages/screens.dart';
// import 'package:cryptox/widget/column_builder.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Plan Bonus Details .dart';
import 'package:gold247/models/user.dart';
import 'referral_bonus_details.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/language/locale.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key key}) : super(key: key);

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  double gold = 0.0;
  String amount;
  double totalbonus = 0.0;
  Future getreferrals(String referralId) async {
    totalbonus = 0.0;
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/referral?refereedBy=${referralId}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      List<referral> t =
          List<referral>.from(l.map((model) => referral.fromJson(model)));
      for (int i = 0; i < t.length; i++) {
        totalbonus += double.parse(t[i].bonus);
      }
      return t;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getportfoliobalance() async {
    var request = http.Request('GET',
        Uri.parse('${baseurl}/api/subscription/balance/user/${Userdata.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num b = responseString['data']['totalBalance'];
      gold = b.toDouble();
    } else {
      print(response.reasonPhrase);
    }
  }

  List<subscription> temp;
  double planBonus = 0.0;
  double totalplanbonus = 0.0;
  double totalplanbonusbyweight = 0.0;
  double totalplanbonusbyvalue = 0.0;
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
      double n = 0.0;
      for (int i = 0; i < temp.length; i++) {
        for (int j = 0; j < temp[i].installments().length; j++) {
          n += double.parse(temp[i].installments()[j].gold.toStringAsFixed(2));
        }
      }
      planBonus = n;
      num d = det['value'];
      totalplanbonusbyvalue = d.toDouble();
      num b = det['weight'];
      totalplanbonusbyweight = b.toDouble();
      totalplanbonus = totalplanbonusbyvalue + totalplanbonusbyweight;
    } else {
      print(response.reasonPhrase);
    }

    return temp;
  }

  double instantBonus = 0.0;
  getwalletBalance() async {
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/wallet/${Userdata.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num d = responseString['data']['gold'];
      instantBonus = d.toDouble();
    } else {
      print(response.reasonPhrase);
    }
  }

  getcalculation() async {
    var request = http.Request('GET',
        Uri.parse('${baseurl}/api/calculation/617f87af1cff6bdaddd477eb'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num d = responseString['data']['Percentage'];
      instantBonus = d.toDouble() * planBonus;
    } else {
      print(response.reasonPhrase);
    }
  }

  buysellprice data = buysellprice();
  Future fetchData() async {
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/buy-sell-price/letest'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);

      data = buysellprice.fromJson(det['data']);
      amount = (gold * num.parse(data.buy).toDouble()).toStringAsFixed(2);
    } else {
      print(response.reasonPhrase);
    }

    return data;
  }

  Future<bool> init() async {
    await getportfoliobalance();
    await getwalletBalance();
    await fetchData();
    //await getcalculation();
    await getplans();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    portfolioValue() {
      // double width = MediaQuery.of(context).size.width;
      return Material(
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.only(bottom: fixPadding * 1.5),
          color: whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              valueItem(locale.totalSaved, '${gold.toStringAsFixed(2)} GRAM'),
              Container(
                height: 8.h,
                width: 0.5.w,
                color: primaryColor,
              ),
              valueItem(locale.currentValue, 'INR ${amount}'),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
      future: init(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: scaffoldBgColor,
                body: Center(
                  child: SpinKitRing(
                    duration: Duration(milliseconds: 500),
                    color: primaryColor,
                    size: 40.0,
                    lineWidth: 1.2,
                  ),
                )),
          );
        } else {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: scaffoldBgColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: whiteColor,
                title: Center(
                  child: Text(
                    locale.yourPortfolio,
                    style: primaryColor18BoldTextStyle,
                  ),
                ),
                elevation: 0.0,
              ),
              body: ListView(
                children: [
                  portfolioValue(),
                  Choice_Card(
                      locale.TotalinPlans,
                      '${planBonus.toStringAsFixed(2)} GRAM',
                      locale.CheckDetails,
                      FontAwesomeIcons.solidCalendarCheck,
                      Market()),
                  Choice_Card(
                      locale.TotalInstant,
                      '${instantBonus.toStringAsFixed(2)} GRAM',
                      locale.CheckDetails,
                      FontAwesomeIcons.coins,
                      BuyGold()),
                  Choice_Card(
                      locale.TotalReferal,
                      '${totalbonus.toStringAsFixed(2)} GRAM',
                      locale.CheckDetails,
                      FontAwesomeIcons.shareAlt,
                      Referal_Bonus_Detials()),
                  Choice_Card(
                      locale.TotalPlanBonus,
                      "${totalplanbonus.toStringAsFixed(2)} GRAM",
                      locale.CheckDetails,
                      FontAwesomeIcons.piggyBank,
                      Plan_Bonnus_Details(
                        byweight: totalplanbonusbyweight.toStringAsFixed(2),
                        byvalue: totalplanbonusbyvalue.toStringAsFixed(2),
                      )),
                  // myPortfolioItems(),
                  SizedBox(height: 2.h),
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

  valueItem(title, value) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      //width: (width) / 3,
      padding: EdgeInsets.only(left: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: grey14BoldTextStyle,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                value,
                style: black16SemiBoldTextStyle,
              ),
            ],
          ),
          // Container(
          //   height: 30.0,
          //   width: 0.7,
          //   color: greyColor.withOpacity(0.6),
          // )
        ],
      ),
    );
  }

  Choice_Card(
    String mainText,
    String amount,
    String bottomText,
    IconData icons,
    Widget navigateTo,
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
                        child: navigateTo));
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
                              '$amount',
                              style: black16SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 6.w,
                      color: primaryColor,
                    ),
                  ],
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
                        child: navigateTo));
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
}
