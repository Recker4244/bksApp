import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/apointmentdetails.dart';
import 'package:gold247/models/appointment.dart';
import 'package:gold247/models/order.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:gold247/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class Appointmentdetails extends StatefulWidget {
  final id;
  Appointmentdetails({this.id});
  @override
  AppointmentdetailsState createState() => AppointmentdetailsState();
}

class AppointmentdetailsState extends State<Appointmentdetails> {
  AppointmentDetails appointmentdet = AppointmentDetails();
  Future getAppointmentDetails() async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/appointment/${widget.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      print(det);
      appointmentdet = AppointmentDetails.fromJson(det['data']);
      await getSystemUser(appointmentdet.user.id);
    } else {
      print(response.reasonPhrase);
    }
    return true;
  }

  String verifier;
  getSystemUser(String id) async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/system-user/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = json.decode(responseString);
      verifier = det['name'];
      print(verifier);
      //print(responseString);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    Widget box1() {
      return Container(
        decoration: BoxDecoration(
          color: scaffoldLightColor,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/crypto_icon/gold_ingots.png'),
              Container(
                height: 20,
              ),
              Text(
                "${appointmentdet.weight} GRAM OLD GOLD SELL".toUpperCase(),
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    box2() {
      return Container(
        decoration: BoxDecoration(
          color: scaffoldLightColor,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  locale.appoinmentDetails.toUpperCase(),
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Order ID",
                          //locale.OrderID,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale.reqeustPlacedOn,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale.Status,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale.verificationDate,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale.verifier,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale.Valuation,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale.StoreLocation,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appointmentdet.id,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appointmentdet.buySellPrice.createdAt,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appointmentdet.status,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appointmentdet.appointmentDate != null
                              ? "${appointmentdet.appointmentDate} - ${appointmentdet.appointmentTime}"
                              : "",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${verifier}",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "INR ${appointmentdet.buySellPrice.sell}",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (!await launch(appointmentdet.storeLocation))
                              throw 'could not launch';
                          },
                          child: Text(
                            locale.directions,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    box3() {
      return Container(
        decoration: BoxDecoration(
          color: scaffoldLightColor,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Verification OTP",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      appointmentdet.opt,
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
      future: getAppointmentDetails(),
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
              backgroundColor: scaffoldLightColor,
              appBar: AppBar(
                foregroundColor: primaryColor,
                backgroundColor: scaffoldLightColor,
                titleSpacing: 0.0,
                elevation: 0.0,
                title: Text(
                  locale.appoinmentDetails,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              body: ListView(
                children: [
                  box1(),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: scaffoldBgColor,
                  ),
                  box2(),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: scaffoldBgColor,
                  ),
                  box3(),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: scaffoldBgColor,
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
