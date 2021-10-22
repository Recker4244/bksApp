import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/order.dart';
import 'package:gold247/models/orderDetails.dart';
import 'package:gold247/pages/Eshop/itemdetails.dart';
import 'package:gold247/models/user.dart';
import 'package:flutter/material.dart';
import 'package:gold247/pages/profile/Shop_order_details.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:gold247/language/locale.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<order> temp;
  List<order> processing;
  List<order> cancelled;
  List<order> delivered;

  changeStatus(String id) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://goldv2.herokuapp.com/api/order/status/$id'));
    request.body = json.encode({"status": "Cancelled"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      await getordersbyid();
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getordersbyid() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://goldv2.herokuapp.com/api/order/user/${Userdata.sId}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      temp = List<order>.from(l.map((model) => order.fromJson(model)));
      processing = temp
          .where((item) =>
              item.status == "Processing" ||
              item.status == "Delivery Boy Assigned")
          .toList();
      delivered = temp.where((item) => item.status == "Delivered").toList();
      cancelled = temp.where((item) => item.status == "Cancelled").toList();
    } else {
      print(response.reasonPhrase);
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getordersbyid(),
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
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  backgroundColor: scaffoldBgColor,
                  automaticallyImplyLeading: false,
                  title:
                      Text('Your Orders', style: primaryColor22BoldTextStyle),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF95203D),
                      size: 32.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  bottom: TabBar(
                    labelColor: primaryColor,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Processing',
                      ),
                      Tab(text: 'Cancelled'),
                      Tab(
                        text: 'Delivered',
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
        return ProcessingCard(
          processing[index].sId,
          "",
          //processing[index].item.productName.toUpperCase(),
          "INR ${processing[index].amount.toStringAsFixed(2)}",
          'TRACK ORDER',
          'CANCEL ORDER',
          Yourorderdetails(id: processing[index].sId),
        );
      },
      itemCount: processing.length,
    );
  }

  Cancelled() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Choice_Card2(
            cancelled[index].sId,
            "",
            //cancelled[index].item.productName.toUpperCase(),
            "INR ${cancelled[index].amount.toStringAsFixed(2)}",
            'ORDER DETAIL',
            Yourorderdetails(
              id: cancelled[index].sId,
            ));
      },
      itemCount: cancelled.length,
    );
  }

  Deliverd() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Choice_Card2(
            delivered[index].sId,
            "",
            //delivered[index].item.productName.toUpperCase(),
            "INR ${delivered[index].amount.toString()}",
            'ORDER DETAIL',
            Yourorderdetails(
              id: delivered[index].sId,
            ));
      },
      itemCount: delivered.length,
    );
  }

  ProcessingCard(
    String id,
    String mainText,
    String amount,
    String bottomText1,
    String bottomText2,
    Widget navigateTo1,
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
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: Yourorderdetails(
                                    id: id,
                                  )));
                        },
                        icon: Icon(Icons.arrow_forward_ios_outlined,
                            color: primaryColor)),
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
                            child: Yourorderdetails(
                              id: id,
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
                      '$bottomText1'.toUpperCase(),
                      style: primaryColor16BoldTextStyle,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    changeStatus(id);
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

  Choice_Card2(
    String id,
    String mainText,
    String amount,
    String bottomText,
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
                        child: Yourorderdetails(
                          id: id,
                        )));
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
