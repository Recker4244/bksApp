import 'package:gold247/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/language/locale.dart';

class Collectiondetails extends StatefulWidget {
  String name;
  subscription temp;
  Collectiondetails({this.temp, this.name});
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
        width: double.infinity,
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
                          locale.collectorPhoneNumber,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      widget.temp != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                locale.Collector,
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale.ToCollect,
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
                          "#${widget.temp.id}",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.temp.createdAt(),
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.temp.status().toUpperCase(),
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.temp.planBonus.toString(),
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      widget.temp != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Abhishek Kumar",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "INR ${widget.temp.savedAmount}",
                          //"INR ${widget.temp.amount}",
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
