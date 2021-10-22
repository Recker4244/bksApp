import 'package:gold247/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/appointment.dart';
import 'package:gold247/models/order.dart';
import 'package:gold247/language/locale.dart';

class Appointmentdetails extends StatefulWidget {
  final appointment temp;
  Appointmentdetails({this.temp});
  @override
  AppointmentdetailsState createState() => AppointmentdetailsState();
}

class AppointmentdetailsState extends State<Appointmentdetails> {
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
                "${widget.temp.weight} GRAM OLD GOLD SELL".toUpperCase(),
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
                          locale.OrderID,
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
                          widget.temp.sId,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.temp.appointmentDate,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.temp.status.toUpperCase(),
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.temp.updatedAt,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.temp.verifier.name,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "INR ${widget.temp.valuation}",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
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
                      widget.temp.otp,
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
  }
}
