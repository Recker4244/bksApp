import 'package:gold247/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/language/locale.dart';
import 'package:gold247/models/user.dart';
import 'package:sizer/sizer.dart';

class Collectiondetails extends StatefulWidget {
  String name;
  //   finalsubscription temp;
  final collection;
  Collectiondetails({this.name, this.collection});
  @override
  CollectiondetailsState createState() => CollectiondetailsState();
}

class CollectiondetailsState extends State<Collectiondetails> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    box2() {
      return Container(
        decoration: BoxDecoration(
          color: scaffoldLightColor,
        ),
        // width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  locale.collectionDetails.toUpperCase(),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Order ID:",
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
                      "#${widget.collection.id}",
                      //"#${widget.temp.id}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Plan Enrolled on:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${DateTime.parse(widget.collection.createdAt).toString()}",
                      //widget.temp.createdAt(),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      locale.collectorPhoneNumber,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${Userdata.mobile}",
                      //widget.temp.status().toUpperCase(),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Collector:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${Userdata.fname}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Status:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.collection.status}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "To Pay:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "INR ${widget.collection.amount}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Landmark:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${Userdata.addresses.first.landMark}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Pincode:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${Userdata.addresses.first.pin}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
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

    box3() {
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
                  "Mode of Payment",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Collect from Your Location",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 14,
                  ),
                ),
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
          locale.collectionDetails,
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
              widget.name.toUpperCase(),
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
