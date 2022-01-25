import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/appointment.dart';
import 'package:gold247/models/order.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/pages/Eshop/eshop.dart';
import 'package:gold247/pages/Eshop/itemdetails.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter/material.dart';
import 'package:gold247/pages/profile/Appointment_Details.dart';
import 'package:gold247/pages/profile/Shop_order_details.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:gold247/models/user.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<appointment> temp;
  List<appointment> processing;
  List<appointment> cancelled;
  List<appointment> delivered;
  Future getAppointments() async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/appointment/user/${Userdata.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      temp =
          List<appointment>.from(l.map((model) => appointment.fromJson(model)));

      processing = temp
          .where((item) =>
              item.status == "Request Placed" ||
              item.status == "Verifier Assigned")
          .toList();
      delivered =
          temp.where((item) => item.status == "Bank Transfer Done").toList();
      cancelled = temp
          .where((item) => item.status == "Offer Declined by User")
          .toList();
    } else {
      print(response.reasonPhrase);
    }

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAppointments(),
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
                  title: Text('Your Appointments',
                      style: primaryColor22BoldTextStyle),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF95203D),
                      size: 30.0,
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
                        text: 'Delivered',
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Processing(),
                    Cancelled(),
                    Delivered(),
                  ],
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

  Processing() {
    return ListView.builder(
      itemBuilder: (context, index) {
        String name =
            "${processing[index].weight} GRAM ${processing[index].valuation} GOLD";
        return Choice_Card1(
            name,
            'INR ${processing[index].valuation}',
            'TRACK APPOINTMENTS',
            'CANCEL',
            Eshop(),
            Eshop(),
            processing[index]);
      },
      itemCount: processing.length,
    );
  }

  Cancelled() {
    return ListView.builder(
      itemBuilder: (context, index) {
        String name =
            "${cancelled[index].weight} GRAM ${cancelled[index].valuation} GOLD";
        return Choice_Card2(name, 'INR ${cancelled[index].valuation}',
            'ORDER DETAIL', Eshop(), cancelled[index]);
      },
      itemCount: cancelled.length,
    );
  }

  Delivered() {
    return ListView.builder(
      itemBuilder: (context, index) {
        String name =
            "${delivered[index].weight} GRAM ${delivered[index].valuation} GOLD";
        return Choice_Card2(name, 'INR ${delivered[index].valuation}',
            'ORDER DETAIL', Eshop(), delivered[index]);
      },
      itemCount: delivered.length,
    );
  }

  Choice_Card1(
      String mainText,
      String amount,
      String bottomText1,
      String bottomText2,
      Widget navigateTo1,
      Widget navigateTo2,
      appointment apt) {
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
                        child: Appointmentdetails(id: apt.id)));
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
                                  child: Appointmentdetails(id: apt.id)));
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
                            child: navigateTo1));
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

  Choice_Card2(String mainText, String amount, String bottomText,
      Widget navigateTo, appointment apt) {
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
                        child: Appointmentdetails(
                          id: "",
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
                        child: Appointmentdetails(
                          id: apt.id,
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
