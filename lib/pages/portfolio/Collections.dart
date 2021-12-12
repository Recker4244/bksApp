import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/customSub.dart';
import 'package:gold247/models/standardSub.dart';
import 'package:gold247/pages/Eshop/eshop.dart';
import 'package:gold247/pages/Eshop/itemdetails.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gold247/pages/profile/Collection_Details.dart';
import 'package:http/http.dart' as http;
import 'package:gold247/models/subscription.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Collections extends StatefulWidget {
  const Collections({Key key}) : super(key: key);

  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  List<subscription> temp;
  List res = [];
  List processing = [];
  List cancelled = [];
  List complete = [];
  changeStatus(String id) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${baseurl}/api/order/status/$id'));
    request.body = json.encode({"status": "Cancelled"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      await getplans();
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    res = [];
    processing = [];
    cancelled = [];
    complete = [];
    super.initState();
  }

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
      for (int i = 0; i < temp.length; i++) {
        for (int j = 0; j < temp[i].installments().length; j++) {
          if (temp[i].installments()[j].mode == "COD") {
            res.add(temp[i].installments()[j]);
          }
        }
      }
      processing = res
          .where((element) =>
              element.status == "Plan Initiated" ||
              element.status == "Processing")
          .toList();
      cancelled =
          res.where((element) => element.status == "Cancelled").toList();
      complete = res.where((element) => element.status == "Completed").toList();
    } else {
      print(response.reasonPhrase);
    }

    return temp;
  }

  // Future getplans() async {
  //   var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  //   var request = http.Request(
  //       'GET', Uri.parse('${baseurl}/api/subscription/user/${Userdata.id}'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     final responseString = await response.stream.bytesToString();
  //     Map det = jsonDecode(responseString);
  //     Iterable l = det['data'];
  //     temp = List<subscription>.from(
  //         l.map((model) => subscription.fromJson(model)));
  //     for (int i = 0; i < temp.length; i++) {
  //       for (int j = 0; j < temp[i].installments.length; j++) {
  //         if (temp[i].installments[j].mode == "COD") {
  //           res.add(temp[i].installments[j]);
  //         }
  //       }
  //     }
  //     processing = res
  //         .where((element) =>
  //             element.status == "Plan Initiated" ||
  //             element.status == "Processing")
  //         .toList();
  //     cancelled =
  //         res.where((element) => element.status == "Cancelled").toList();
  //     complete = res.where((element) => element.status == "Completed").toList();
  //   } else {
  //     print(response.reasonPhrase);
  //   }

  //   return temp;
  // }

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
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  backgroundColor: whiteColor,
                  automaticallyImplyLeading: false,
                  title: Text('Your Collections',
                      style: primaryColor22BoldTextStyle),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF95203D),
                      size: 32.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  bottom: const TabBar(
                    labelColor: Colors.grey,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    indicatorColor: primaryColor,
                    tabs: [
                      Tab(
                        text: 'Processing',
                      ),
                      Tab(text: 'Cancelled'),
                      Tab(
                        text: 'Complete',
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Processing(),
                    Cancelled(),
                    Deliverd(),
                  ],
                ),
              ),
            );
          } else {
            return SafeArea(
                child: Scaffold(
                    backgroundColor: scaffoldBgColor,
                    body: Text(" Oops !! No data ")));
          }
        }
      },
    );
  }

  Processing() {
    return ListView.builder(
      itemBuilder: (context, index) {
        subscription plan = temp.singleWhere(
            (element) => element.installments().contains(processing[index]),
            orElse: () => null);

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
                            child: Collectiondetails(
                                temp: plan, name: plan.planName())));
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
                                  '${plan.planName()}',
                                  style: grey12BoldTextStyle,
                                ),
                                height5Space,
                                Text(
                                  '${plan.savedAmount()}',
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
                                child: Collectiondetails(
                                  temp: plan,
                                  name: plan.planName(),
                                )));
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
                          'Track collection'.toUpperCase(),
                          style: primaryColor14MediumTextStyle,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        changeStatus(plan.id());
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
                          'Cancel collection'.toUpperCase(),
                          style: primaryColor14MediumTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                // InkWell(
                //   onTap: () {
                //     // Navigator.push(
                //     //     context,
                //     //     PageTransition(
                //     //         type: PageTransitionType.size,
                //     //         alignment: Alignment.bottomCenter,
                //     //         child: ));
                //   },
                //   borderRadius: BorderRadius.vertical(
                //     bottom: Radius.circular(10.0),
                //   ),
                //   child: Container(
                //     padding: EdgeInsets.all(fixPadding),
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.vertical(
                //         bottom: Radius.circular(10.0),
                //       ),
                //       color: Colors.white,
                //     ),
                //     child: Text(
                //       'cancel collection'.toUpperCase(),
                //       style: primaryColor16BoldTextStyle,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
      itemCount: processing.length,
    );
  }

  Cancelled() {
    return ListView.builder(
      itemBuilder: (context, index) {
        String plan = temp
            .singleWhere((element) =>
                element.installments().contains(cancelled[index].id))
            .planName();
        return Choice_Card2(
            '${plan.toUpperCase()}',
            'INR ${cancelled[index].amount}',
            'COLLECTION DETAIL',
            Eshop(),
            cancelled[index]);
      },
      itemCount: cancelled.length,
    );
  }

  Deliverd() {
    return ListView.builder(
      itemBuilder: (context, index) {
        String plan = temp
            .singleWhere((element) =>
                element.installments().contains(complete[index].id))
            .planName();
        return Choice_Card1(
            '${plan.toUpperCase()}',
            'INR 4330.0',
            'COLLECTION DETAIL',
            'COLLECTION DETAIL',
            Eshop(),
            Eshop(),
            complete[index]);
      },
      itemCount: complete.length,
    );
  }

  Choice_Card1(
    String mainText,
    String amount,
    String bottomText1,
    String bottomText2,
    Widget navigateTo1,
    Widget navigateTo2,
    final inst,
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
              onTap: () {},
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
                  onTap: () {},
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
                      style: primaryColor14MediumTextStyle,
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
                      style: primaryColor14MediumTextStyle,
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

  Choice_Card2(
    String mainText,
    String amount,
    String bottomText,
    Widget navigateTo,
    final inst,
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
              onTap: () {},
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
