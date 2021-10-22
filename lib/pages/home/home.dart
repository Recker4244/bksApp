import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/StandPlans.dart';
import 'package:gold247/models/appointment.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/pages/home/byValue_Stan.dart';
import 'package:gold247/pages/home/byWeightStandard.dart';

import 'package:gold247/pages/screens.dart';
import 'package:gold247/pages/currencyScreen/buy_gold.dart';
import 'package:gold247/pages/currencyScreen/sell_gold.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'byValue_Wght.dart';
import 'byWght_Value.dart';
import 'byValue_ProceedF.dart';
import 'sellOldgold.dart';
import 'package:gold247/models/user.dart';
import 'package:sizer/sizer.dart';
import 'package:share/share.dart';
import 'byWeightStandard.dart';
import 'package:gold247/language/locale.dart';
import 'package:gold247/language/locale.dart';

Map MapVal;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String reffer;
  List<standardplan> Standardplans;
  List portfolioItems;
  String goldbalance = '0';

  String bonusbalance = '0';

  Future getportfoliobalance() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/subscription/balance/user/${Userdata.sId}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num b = responseString['data']['totalBalance'];
      goldbalance = b.toStringAsFixed(2);
    } else {
      print(response.reasonPhrase);
    }
  }

  buysellprice data = buysellprice();
  Future fetchData() async {
    var request = http.Request('GET',
        Uri.parse('https://goldv2.herokuapp.com/api/buy-sell-price/letest'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);

      data = buysellprice.fromJson(det['data']);
    } else {
      print(response.reasonPhrase);
    }

    return data;
  }

  Future fetchStandardPlans() async {
    http.Response response;
    response = await http
        .get(Uri.parse("https://goldv2.herokuapp.com/api/plan/type/standard/"));

    // response code 200 means that the request was successful
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);

      Iterable l = responseString['data'];
      Standardplans = List<standardplan>.from(
          l.map((model) => standardplan.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
  }

  // String calVal(int mode, int weight, int duration, int bonus, int value) {
  //   if (mode == 1) {
  //     return ((weight * duration) * (1 + bonus * 0.01)).toStringAsPrecision(3);
  //   } else {
  //     return (((value / int.parse(data.kt24.buy) * duration) * (1 + bonus * 0.01))
  //         .toStringAsPrecision(3);
  //   }
  // }

  subscription Subscription = subscription();
  Future getGoldBalance() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/subscription/balance/${Userdata.sId}/${Subscription.sId}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      int gold = det['planBalance'];
      goldbalance = gold.toString();
      bonusbalance = (gold * 0.1).toString();
    } else {
      print(response.reasonPhrase);
    }
  }

  double bonusPercentage;
  Future getcalculation() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/calculation/5f3f9e5b5229ec11f804dd5c'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num d = responseString['data']['Percentage'];
      bonusPercentage = (d.toDouble()) / 100;
      return d;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<bool> init;
  Future<bool> initialise() async {
    await getportfoliobalance();
    await getcalculation();
    //await getGoldBalance();
    await fetchStandardPlans();
    await fetchData();
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;

    userGreeting() {
      return Padding(
        padding: EdgeInsets.all(fixPadding * 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.welcome,
                  style: grey16MediumTextStyle,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  Userdata.fname ?? "Unknown User" + ' To BKS',
                  style: black22BoldTextStyle,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBar(index: 4),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/user/default.jpeg',
                  width: 16.w,
                  height: 8.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    }

    balanceContainer() {
      return Container(
        padding: EdgeInsets.all(fixPadding * 2.0),
        margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locale.PortoflioBalance,
              style: white16MediumTextStyle,
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "${goldbalance} ${locale.GRAM}",
              style: white36BoldTextStyle,
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.TotalBalance,
                      style: white16MediumTextStyle,
                    ),
                    heightSpace,
                    Text(
                      '${bonusbalance} ${locale.GRAM}',
                      style: white26BoldTextStyle,
                    ),
                  ],
                ),
                // Container(
                //   padding: EdgeInsets.all(fixPadding * 0.7),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20.0),
                //     color: whiteColor,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.arrow_drop_up,
                //         size: 26.0,
                //         color: primaryColor,
                //       ),
                //       Text(
                //         '10%',
                //         style: primaryColor14MediumTextStyle,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            )
          ],
        ),
      );
    }

    buyGold(String Byprice) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: blackColor.withOpacity(0.05),
              ),
            ],
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
                          child: BuyGold()));
                },

                //TODO : Push to Buy Gold

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    color: scaffoldBgColor.withOpacity(0.5),
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
                            height: 5.h,
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage(goldIngotsPath),
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
                                '24 KT GOLD',
                                style: primaryColor18BoldTextStyle,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    locale.BuyRate,
                                    style: grey14BoldTextStyle,
                                  ),
                                  Icon(
                                    data.buyChange > 0
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: data.buyChange > 0
                                        ? greenColor
                                        : redColor,
                                  ),
                                  Text(
                                    '${(data.buyChange).abs()}%',
                                    style: black14BoldTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'INR ${Byprice.toString()}', //TODO insert buy price
                        style: black18BoldTextStyle,
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
                    color: whiteColor,
                  ),
                  child: Text(
                    locale.BuyInstantGold.toUpperCase(),
                    style: primaryColor16MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    sellGold(String sellprice) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: blackColor.withOpacity(0.05),
              ),
            ],
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
                          child: SellGold()));
                },

                //TODO : Push to Buy Gold

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    color: scaffoldBgColor.withOpacity(0.5),
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
                            height: 5.h,
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage(goldIngotsPath),
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
                                '24 KT GOLD',
                                style: primaryColor18BoldTextStyle,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    locale.SellRate,
                                    style: grey14BoldTextStyle,
                                  ),
                                  Icon(
                                    data.sellChange > 0
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: data.sellChange > 0
                                        ? greenColor
                                        : redColor,
                                  ),
                                  Text(
                                    '${(data.sellChange).abs()}%',
                                    style: black14BoldTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'INR ${sellprice.toString()}', //TODO Sell price
                        style: black18BoldTextStyle,
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
                    color: whiteColor,
                  ),
                  child: Text(
                    locale.SellInstantGold.toUpperCase(),
                    style: primaryColor16MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    myPortfolio() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: fixPadding * 2.0,
              bottom: fixPadding,
            ),
            child: Text(
              locale.BuySave,
              style: primaryColor16BoldTextStyle,
            ),
          ),
          Container(
            width: double.infinity,
            height: 22.h,
            child: ListView.builder(
              itemCount: Standardplans.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = Standardplans[index];

                return Padding(
                  padding: (index != Standardplans.length - 1)
                      ? EdgeInsets.only(left: fixPadding * 2.0)
                      : EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        if (item.mode == "value") {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: standardValue(
                                      planname: "${Standardplans[index].name}",
                                      duration: Standardplans[index].duration,
                                      durationString:
                                          "${Standardplans[index].duration} ${item.cyclePeriod.shortName}",
                                      cycleid:
                                          Standardplans[index].cyclePeriod.sId,
                                      shortname: item.cyclePeriod.shortName,
                                      planID: item.sId)));
                        } else
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: Standard_PC(
                                    planname: "${Standardplans[index].name}",
                                    duration: Standardplans[index].duration,
                                    durationString:
                                        "${Standardplans[index].duration} ${item.cyclePeriod.shortName}",
                                    cycleid:
                                        Standardplans[index].cyclePeriod.sId,
                                    shortname: item.cyclePeriod.shortName,
                                    planID: item.sId,
                                  )));
                      },
                      child: Container(
                        width: 55.w,
                        padding: EdgeInsets.all(fixPadding),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              color: blackColor.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: Container(
                          color: scaffoldBgColor.withOpacity(0.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 12.w,
                                    height: 5.h,
                                    alignment: Alignment.center,
                                    child: Image(
                                      image: AssetImage(goldIngotsPath),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      Standardplans[index].name,
                                      style: primaryColor16MediumTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                color: whiteColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(locale.BUY,
                                                style:
                                                    primaryColor18BoldTextStyle),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text(
                                              item.mode == "value"
                                                  ? "${item.cyclePeriod.minValue} INR/${item.cyclePeriod.shortName}"
                                                  : "${item.cyclePeriod.minWeight} GRAM/${item.cyclePeriod.shortName}",
                                              style:
                                                  primaryColor14MediumTextStyle,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              locale.SAVE,
                                              style:
                                                  primaryColor18BoldTextStyle,
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text(
                                              "${(item.cyclePeriod.minWeight * item.duration * (1 + bonusPercentage)).toStringAsFixed(2)} GRAM",
                                              style:
                                                  primaryColor14MediumTextStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    planSelector() {
      return Container(
        height: 25.h,
        child: Padding(
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                locale.create,
                style: primaryColor16MediumTextStyle,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: ByWght_Value(
                                      'Create Your Own Plan By Weight')));
                        },
                        child: Container(
                          height: 30.h,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                spreadRadius: 1.0,
                                color: blackColor.withOpacity(0.05),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(fixPadding * 2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.weightHanging,
                                  size: 4.h,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  locale.ByWeight,
                                  style: primaryColor16MediumTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ByValue_Wght(
                                      'Create Your Own Plan By Value')));
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(fixPadding * 2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.rupeeSign,
                                  size: 4.h,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  locale.ByValue,
                                  style: primaryColor16MediumTextStyle,
                                ),
                              ],
                            ),
                          ),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                spreadRadius: 1.0,
                                color: blackColor.withOpacity(0.05),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    referAfriend(String Code) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: blackColor.withOpacity(0.05),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Share.share("$Code", subject: "Referal Code");
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         type: PageTransitionType.size,
                  //         alignment: Alignment.bottomCenter,
                  //         child: TotalBalance()));
                },

                //TODO : Push to refer a friend

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    color: scaffoldBgColor.withOpacity(0.5),
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
                              Icons.share,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.yourcode,
                                style: black12RegularTextStyle,
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                Code,
                                style: black16MediumTextStyle,
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
                    color: whiteColor,
                  ),
                  child: Text(
                    locale.refer.toUpperCase(),
                    style: primaryColor16MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    SellOldGold(double sell24, double sell22, double sell18, {width}) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: blackColor.withOpacity(0.05),
              ),
            ],
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
                      child: SellOld(),
                    ),
                  );
                },

                //TODO : Push to refer a friend

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    color: scaffoldBgColor.withOpacity(0.5),
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      if (width < 400)
                        Column(
                          children: [
                            width5Space,
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: primaryColor,
                            ),
                            width5Space,
                          ],
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '24 KT',
                            style: primaryColor16BoldTextStyle,
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            "INR $sell24",
                            style: black16RegularTextStyle,
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            locale.perGrame,
                            style: black12RegularTextStyle,
                            softWrap: true,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Container(
                        height: 4.h,
                        width: 0.5.w,
                        color: primaryColor,
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '22 KT',
                            style: primaryColor16BoldTextStyle,
                            softWrap: true,
                          ),
                          height5Space,
                          Text(
                            "INR $sell22",
                            style: black16RegularTextStyle,
                            softWrap: true,
                          ),
                          height5Space,
                          Text(
                            locale.perGrame,
                            style: black12RegularTextStyle,
                            softWrap: true,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Container(
                        height: 4.h,
                        width: 0.5.w,
                        color: primaryColor,
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '18 KT',
                            style: primaryColor16BoldTextStyle,
                            softWrap: true,
                          ),
                          height5Space,
                          Text(
                            "INR $sell18",
                            style: black16RegularTextStyle,
                            softWrap: true,
                          ),
                          height5Space,
                          Text(
                            locale.perGrame,
                            style: black12RegularTextStyle,
                            softWrap: true,
                          ),
                        ],
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
                    color: whiteColor,
                  ),
                  child: Text(
                    locale.Sellyour.toUpperCase(),
                    style: primaryColor16MediumTextStyle,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
      future: init,
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
            return SafeArea(
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    userGreeting(),
                    balanceContainer(),
                    buyGold(data.buy.toStringAsFixed(2)),
                    sellGold(data.sell.toStringAsFixed(2)),
                    height20Space,
                    myPortfolio(),
                    height20Space,
                    planSelector(),
                    referAfriend(Userdata.refCode.toString()),
                    SellOldGold(
                        double.parse(data.sell.toStringAsFixed(2)),
                        double.parse((data.sell * 0.85).toStringAsFixed(2)),
                        double.parse((data.sell * 0.75).toStringAsFixed(2)),
                        width: width),
                  ],
                ),
              ),
            );
          } else {
            return SafeArea(
                child: Scaffold(
                    backgroundColor: scaffoldBgColor,
                    body: Text(" Oops !! Something went wrong ")));
          }
        }
      },
    );
  }
}
