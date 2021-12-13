import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/StandPlans.dart';

import 'package:gold247/models/Metalgroup.dart';
import 'package:gold247/models/offerList.dart';
import 'package:gold247/pages/home/byValue_Stan.dart';
import 'package:gold247/pages/home/byWeightStandard.dart';
import 'package:gold247/pages/portfolio/referral_bonus_details.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/pages/currencyScreen/buy_gold.dart';
import 'package:gold247/pages/currencyScreen/sell_gold.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'byValue_Wght.dart';
import 'byWght_Value.dart';
import 'byValue_ProceedF.dart';
import 'sellOldgold.dart';
import 'package:gold247/models/user.dart';
import 'package:sizer/sizer.dart';
import 'package:share/share.dart';
import 'byWeightStandard.dart';
import 'package:gold247/language/locale.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Map MapVal;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ItemScrollController _scrollController = ItemScrollController();
  String reffer;
  List<standardplan> Standardplans;
  List portfolioItems;
  String goldbalance = '0';

  String bonusbalance = '0';

  Future getportfoliobalance() async {
    var request = http.Request('GET',
        Uri.parse('${baseurl}/api/subscription/balance/user/${Userdata.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num b = responseString['data']['totalBalance'];
      goldbalance = b.toStringAsFixed(2);
    } else {
      print(response.reasonPhrase);
    }
  }

  List<offerList> offers = [];
  Future getoffers() async {
    var request = http.Request('GET', Uri.parse('${baseurl}/api/offer'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();

      Iterable l = json.decode(responseString);
      offers =
          List<offerList>.from(l.map((model) => offerList.fromJson(model)));
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
    } else {
      print(response.reasonPhrase);
    }

    return data;
  }

  Future fetchStandardPlans() async {
    http.Response response;
    response = await http.get(Uri.parse("${baseurl}/api/plan/type/standard/"));

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

  num tokenGoldPercentage;
  Future getTokengoldCalculation() async {
    var request = http.Request('GET',
        Uri.parse('${baseurl}/api/calculation/61b3a8add59d6bacdd6ef5a2'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num d = responseString['data'][0]['Percentage'];
      tokenGoldPercentage = d / 100;
    } else {
      print(response.reasonPhrase);
    }
  }

  double bonusPercentage;
  Future getcalculation() async {
    var request = http.Request('GET',
        Uri.parse('${baseurl}/api/calculation/61b3a86dd59d6bacdd6ef59f'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = jsonDecode(await response.stream.bytesToString());
      num d = responseString['data'][0]['Percentage'];
      bonusPercentage = (d.toDouble()) / 100;
      return d;
    } else {
      print(response.reasonPhrase);
    }
  }

  List<MetalGroup> temp = [];
  Future getMetals() async {
    var request = http.Request('GET', Uri.parse('${baseurl}/api/metal-group'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();

      Iterable t = jsonDecode(responseString);
      temp =
          List<MetalGroup>.from(t.map((model) => MetalGroup.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return temp;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var locale = AppLocalizations.of(context);
    createtokenGoldRequest(
        parti.id,
        Userdata.id,
        data.id,
        weight.text,
        "61b3a8add59d6bacdd6ef5a2",
        response.paymentId,
        (num.parse(weight.text) *
                tokenGoldPercentage *
                data.buy *
                parti.referenceId)
            .toStringAsFixed(2));
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
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
                      locale.REQUESTPLACED,
                      style: black16BoldTextStyle,
                    )),
                    Center(
                        child: Text(
                      locale.SUCCESS,
                      style: black14MediumTextStyle,
                    )),
                    heightSpace,
                    Center(
                      child: Container(
                        color: whiteColor,
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(response.paymentId),
                        )),
                      ),
                    ),
                    height20Space,
                    Center(
                        child: Text(
                      locale.taptocopy,
                      style: black12MediumTextStyle,
                    )),
                    heightSpace,
                    Center(
                        child: Text(
                      locale.showcode,
                      style: black12MediumTextStyle,
                    ))
                  ],
                ),
              ),
            ));
  }

  _handlePaymentError(PaymentFailureResponse response) {
    var locale = AppLocalizations.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: scaffoldBgColor,
              title: Center(
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.sms_failed_rounded,
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
                      locale.REQUESTFAILED,
                      style: black16BoldTextStyle,
                    )),
                    Center(
                        child: Text(
                      locale.FAILED,
                      style: black14MediumTextStyle,
                    )),
                    heightSpace,
                  ],
                ),
              ),
            ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  Future<bool> init;
  Future<bool> initialise() async {
    await getoffers();
    await getportfoliobalance();
    await getcalculation();
    await getTokengoldCalculation();
    //await getGoldBalance();
    await fetchStandardPlans();
    await fetchData();
    await getMetals();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    if (temp != null) {
      CyclePController = temp.first.id;
      parti = temp.first;
    }

    return true;
  }

  String amount;
  TextEditingController weight = TextEditingController(text: "1");
  String CyclePController;
  List<MetalGroup> temp1 = [];
  MetalGroup parti;
  Future getMetalbyID(String id) async {
    MetalGroup metal = MetalGroup();
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/metal-group/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      List d = jsonDecode(responseString);
      Iterable l = d;
      temp1 =
          List<MetalGroup>.from(l.map((model) => MetalGroup.fromJson(model)));
      metal = temp1[0];
    } else {
      print(response.reasonPhrase);
    }
    return metal;
  }

  Razorpay _razorpay;
  final Rkey = 'rzp_test_wVVGuz2rxyrfFd';
  openCheckout(String amount) async {
    var options = {
      'key': Rkey,
      'amount': (double.parse(amount)) * 100.0,
      'name': "Token Gold",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': Userdata.mobile, 'email': Userdata.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
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
                  height: 0.5.h,
                ),
                Wrap(
                  children: [
                    Text(Userdata.fname ?? "Unknown User" + ' To BKS',
                        style: black22BoldTextStyle.copyWith(
                            fontSize: 30, fontWeight: FontWeight.w600)),
                  ],
                )
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
                  'assets/user/bksmain.png',
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    }

    userdummyGreeting() {
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
                  '',
                  style: grey16MediumTextStyle,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  '',
                  style: black22BoldTextStyle,
                ),
              ],
            ),
            Container(
              height: 80,
              width: 80,
            )
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
                      locale.total,
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

    dummycontainer1() {
      return Container(
        padding: EdgeInsets.all(fixPadding * 2.0),
        margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: primaryColor,
        ),
        height: 250,
      );
    }

    dummybalanceContainer() {
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
            Text(''),
            SizedBox(
              height: 1.h,
            ),
            Text(
                //
                ''),
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
                      locale.total,
                      style: white16MediumTextStyle,
                    ),
                    heightSpace,
                    Text(''),
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
            fixPadding * 2.0, fixPadding * 2.0 - 12, fixPadding * 2.0, 0),
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
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.bottomCenter,
                          child: BuyGold()));
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
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.bottomCenter,
                          child: SellGold()));
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
            height: 18.h,
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
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: GestureDetector(
                      onTap: () {
                        if (item.mode == "value") {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: standardValue(
                                      min: Standardplans[index]
                                          .cyclePeriod
                                          .minValue,
                                      planname: "${Standardplans[index].name}",
                                      duration: Standardplans[index].duration,
                                      durationString:
                                          "${Standardplans[index].duration} ${item.cyclePeriod.shortName}",
                                      cycleid:
                                          Standardplans[index].cyclePeriod.id,
                                      shortname: item.cyclePeriod.shortName,
                                      planID: item.id)));
                        } else
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: Standard_PC(
                                    min: Standardplans[index]
                                        .cyclePeriod
                                        .minWeight,
                                    planname: "${Standardplans[index].name}",
                                    duration: Standardplans[index].duration,
                                    durationString:
                                        "${Standardplans[index].duration} ${item.cyclePeriod.shortName}",
                                    cycleid:
                                        Standardplans[index].cyclePeriod.id,
                                    shortname: item.cyclePeriod.shortName,
                                    planID: item.id,
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
                              SizedBox(
                                height: 1.w,
                              ),
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
                                                  ? "${item.cyclePeriod.minValue} INR/ ${item.cyclePeriod.shortName}"
                                                  : "${item.cyclePeriod.minWeight} GRAM/${item.cyclePeriod.shortName}",
                                              style:
                                                  primaryColor14MediumTextStyle
                                                      .copyWith(
                                                          color: Colors.black),
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
                                                  primaryColor14MediumTextStyle
                                                      .copyWith(
                                                          color: Colors.black),
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

    dummymyportfolio() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: fixPadding * 2.0,
              bottom: fixPadding,
            ),
          ),
          Container(
            width: double.infinity,
            height: 22.h,
            child: ListView.builder(
              itemCount: 3,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: (index != 2 - 1)
                      ? EdgeInsets.only(left: fixPadding * 2.0)
                      : EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
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
                                          'Create Your Own Plan By Weight')))
                              .then((value) {
                            setState(() {
                              initialise();
                            });
                          });
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
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: Referal_Bonus_Detials()));
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded, size: 5.w),
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
                onTap: () {
                  Share.share("$Code", subject: "Referal Code");
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         type: PageTransitionType.size,
                  //         alignment: Alignment.bottomCenter,
                  //         child: TotalBalance()));
                },
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

    SellOldGold(num sell24, num sell22, num sell18, {width}) {
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
                onTap: () {},

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
            body: Shimmer.fromColors(
              baseColor: Color.fromRGBO(255, 253, 228, 1),
              highlightColor: Colors.white,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 20),
                  dummycontainer1(),
                  SizedBox(height: 20),
                  dummybalanceContainer(),
                  SizedBox(height: 20),
                  dummybalanceContainer(),
                  dummymyportfolio(),
                ],
              ),
            ),
          ));
        } else {
          if (snapshot.hasData) {
            List<Widget> item = [
              userGreeting(),
              CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.easeInCubic,
                    //enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      // setState(() {
                      //   _current_slider = index;
                      // });
                    }),
                items: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            width: 100.w,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                    "https://thejewellerydiaries.com/wp-content/uploads/2019/11/dsc4607.jpg",
                                    fit: BoxFit.fitWidth))),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BUY TODAY, SAVE FOR TOMORROW",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Row(
                //mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    height: 25.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  print('clicked');
                                  _scrollController.scrollTo(
                                      index: 10,
                                      duration: Duration(seconds: 1));
                                },
                                icon: ImageIcon(
                                  AssetImage(
                                    "assets/icon/icon1.png",
                                  ),
                                  size: 60,
                                )),
                            Text("Buy and Save",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () {
                                  _scrollController.scrollTo(
                                      index: 5, duration: Duration(seconds: 1));
                                },
                                icon: ImageIcon(
                                    AssetImage("assets/icon/icon3.png"),
                                    size: 60)),
                            Text(
                              "Buy Instant Gold",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: ImageIcon(
                                    AssetImage("assets/icon/icon2.png"),
                                    size: 60)),
                            Text(
                              "Buy Token Gold",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: ImageIcon(
                                    AssetImage("assets/icon/icon4.png"),
                                    size: 60)),
                            Text(
                              "Shop Gold",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 25.h,
                      width: 48.w,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  "https://newspaperads.ads2publish.com/wp-content/uploads/2018/12/ima-jewels-gold-and-diamond-jewellery-ad-times-of-india-bangalore-29-11-2018.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //decoration: BoxDecoration(color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  "https://mir-s3-cdn-cf.behance.net/project_modules/1400/f56f6932790573.56940c8b64c93.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //decoration: BoxDecoration(color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  "https://lh3.googleusercontent.com/p/AF1QipOyJJMN-zcoMpcALVi3VUxkj3E3crqas7gyH7Mj=s1280-p-no-v1",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //decoration: BoxDecoration(color: Colors.red),
                            ),
                          ),
                        ],
                      )
                      //decoration: BoxDecoration(color: Colors.red),
                      ),
                ],
              ),
              Container(
                  height: 55.w,
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 50.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfhH56n_iwWT-0RqBy3Fa83ZF1lD60nM9_Ew&usqp=CAU",
                                fit: BoxFit.fitWidth),
                          ),
                          //decoration: BoxDecoration(color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 50.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                                "https://lh3.googleusercontent.com/p/AF1QipOyJJMN-zcoMpcALVi3VUxkj3E3crqas7gyH7Mj=s1280-p-no-v1",
                                fit: BoxFit.fitWidth),
                          ),
                          //decoration: BoxDecoration(color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 50.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfhH56n_iwWT-0RqBy3Fa83ZF1lD60nM9_Ew&usqp=CAU",
                                fit: BoxFit.fitWidth),
                          ),
                          //decoration: BoxDecoration(color: Colors.red),
                        ),
                      ),
                    ],
                  )),
              buyGold(data.buy.toStringAsFixed(2)),
              sellGold(data.sell.toStringAsFixed(2)),
              height20Space,
              Padding(
                padding: EdgeInsets.only(
                  left: fixPadding * 2.0,
                  bottom: fixPadding,
                ),
                child: Text(
                  "Book Your Gold Now! Pay only 10%",
                  style: primaryColor16BoldTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    fixPadding * 2.0, 0, fixPadding * 2.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: scaffoldLightColor,
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
                      Padding(
                        padding: const EdgeInsets.all(fixPadding * 2),
                        child: Theme(
                          data: ThemeData(
                            errorColor: primaryColor,
                            primaryColor: whiteColor,
                            textSelectionTheme: TextSelectionThemeData(
                              cursorColor: primaryColor,
                            ),
                          ),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String value) {
                              if (value == null || value.isEmpty)
                                return "Please enter the weight you want to save";
                              if (num.parse(value) < 1)
                                return "Weight must be greater than 1";
                              return null;
                            },
                            onChanged: (String value) {
                              if (value != null && value.isNotEmpty)
                                setState(() {
                                  amount = (num.parse(value).toDouble() *
                                          data.buy *
                                          tokenGoldPercentage *
                                          parti.referenceId)
                                      .toStringAsFixed(2);
                                });
                            },
                            controller: weight,
                            keyboardType: TextInputType.number,
                            style: primaryColor18BoldTextStyle,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              fillColor: whiteColor,
                              suffix: Text(locale.GRAM,
                                  style: primaryColor18BoldTextStyle),
                              labelText: locale.WeightofGold,
                              labelStyle: primaryColor18BoldTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(fixPadding * 2),
                        child: Theme(
                          data: ThemeData(
                            primaryColor: primaryColor,
                          ),
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: primaryColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1),
                                  ),
                                  // labelText:
                                  //     locale.selectKarat.toUpperCase(),
                                  // labelStyle: TextStyle(
                                  //     color: Colors.white,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 18.sp),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: whiteColor, width: 0.7),
                                  ),
                                ),
                                isEmpty: CyclePController == '',
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    iconEnabledColor: Colors.white,
                                    value: CyclePController,
                                    isDense: true,
                                    dropdownColor: primaryColor,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                    //primaryColor16MediumTextStyle,
                                    onChanged: (String newValue) async {
                                      MetalGroup newmetal =
                                          temp.firstWhere((MetalGroup i) {
                                        if (i.id == newValue) return true;
                                        return false;
                                      });
                                      // await getMetalbyID(newValue);
                                      setState(() {
                                        CyclePController = newValue;
                                        parti = newmetal;
//state.didChange(newValue);
                                      });
                                    },
                                    items: temp.map((MetalGroup metal) {
                                      return DropdownMenuItem<String>(
                                        value: metal.id,
                                        child: Text(
                                          metal.karatage,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10.0),
                        ),
                        onTap: () {
                          openCheckout((num.parse(weight.text) *
                                  tokenGoldPercentage *
                                  data.buy *
                                  parti.referenceId)
                              .toStringAsFixed(2));
                        },
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
                            "Pay only ${(num.parse(weight.text) * tokenGoldPercentage * data.buy * parti.referenceId).toStringAsFixed(2)} INR to book your ${weight.text} grams of ${parti.karatage} Gold",
                            style: primaryColor14MediumTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              height20Space,
              myPortfolio(),
              height20Space,
              planSelector(),
              height20Space,
              Padding(
                padding: EdgeInsets.only(
                  left: fixPadding * 2.0,
                  bottom: fixPadding,
                ),
                child: Text(
                  locale.refer,
                  style: primaryColor16BoldTextStyle,
                ),
              ),
              referAfriend(Userdata.refCode.toString()),
              height20Space,
              Padding(
                padding: EdgeInsets.only(
                  left: fixPadding * 2.0,
                  bottom: fixPadding,
                ),
                child: Text(
                  locale.sellgoldtitle,
                  style: primaryColor16BoldTextStyle,
                ),
              ),
              SellOldGold(
                  data.sell,
                  double.parse((data.sell * temp[1].referenceId.toDouble())
                      .toStringAsFixed(2)),
                  double.parse((data.sell * temp[2].referenceId.toDouble())
                      .toStringAsFixed(2)),
                  width: width),
            ];

            return SafeArea(
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                body: ScrollablePositionedList.builder(
                  itemCount: item.length,
                  itemScrollController: _scrollController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return item[index];
                  },
                  //  item.map((e) => e).toList(),
                ),
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

void createtokenGoldRequest(
    String metalgroupId,
    String userId,
    String buysellId,
    String weightEntered,
    String calculationId,
    String paymentId,
    String amount) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST', Uri.parse('${baseurl}/token-gold'));
  request.body = json.encode({
    "metalGroup": metalgroupId,
    "user": userId,
    "buySell": buysellId,
    "weightEntered": weightEntered,
    "calculation": calculationId,
    "paymentId": paymentId,
    "amountPaid": amount,
    "status": "Completed",
    "returnReason": null
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
