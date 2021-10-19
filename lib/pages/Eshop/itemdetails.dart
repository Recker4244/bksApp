import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/item.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import '../portfolio/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:gold247/models/user.dart';

class Itemdetails extends StatefulWidget {
  final ItemList item;
  Itemdetails({this.item});
  @override
  _ItemdetailsState createState() => _ItemdetailsState();
}

class _ItemdetailsState extends State<Itemdetails> {
  int count = 1;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
    }
  }
  addToCart() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('https://goldv2.herokuapp.com/api/cart/add/${Userdata.sId}'));
    request.body = json.encode({"itemDetail": widget.item.sId,
      "quantity":count
    }
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '${widget.item.grossweight} GRAM ${widget.item.composition[0].metalGroup.karatage} GOLD',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: scaffoldBgColor,
          ),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 2.0,
        child: Container(
          height: 50.0,
          width: width,
          color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: ()async {
                 await addToCart();
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));

                },
                child: Container(
                  height: 50.0,
                  width: (width - 1.0) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    'ADD TO CART'.toUpperCase(),
                    style: white16BoldTextStyle,
                  ),
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: whiteColor.withOpacity(0.5),
              ),
              InkWell(
                onTap: ()async {
                  await addToCart();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Cart();
                    }),
                  );
                },
                child: Container(
                  height: 50.0,
                  width: (width - 1.0) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    'BUY NOW'.toUpperCase(),
                    style: white16BoldTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: whiteColor.withOpacity(0.5),
              child: Center(
                  child:
                      Image(image: NetworkImage(widget.item.item.images[0]))),
            ),
            Padding(
              padding: const EdgeInsets.all(fixPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'INR ${widget.item.totalAmount}',
                        style: primaryColor22BoldTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: decrement,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  )),
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: Icon(Icons.minimize_sharp),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            child: Text(
                              '$count',
                              style: white16BoldTextStyle,
                            ),
                            padding: EdgeInsets.all(10),
                          ),
                          GestureDetector(
                            onTap: increment,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  )),
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '(Inclusive of all charges)',
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 14.0,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Description',
                        style: primaryColor18BoldTextStyle,
                      ),
                      heightSpace,
                      Text(
                        'Metal Purity : ${widget.item.composition[0].metalGroup.karatage} (${widget.item.composition[0].metalGroup.fineness / 10}%)',
                        style: primaryColor16BoldTextStyle,
                      ),
                      Text(
                        'Packaging : Tamperproof Packaging',
                        style: primaryColor16BoldTextStyle,
                      ),
                      Text(
                        'Weight : ${widget.item.grossweight} gram',
                        style: primaryColor16BoldTextStyle,
                      ),
                      heightSpace,
                      Text(
                        widget.item.description,
                        style: primaryColor16MediumTextStyle,
                      ),
                    ],
                  ),
                  height20Space,
                  height20Space,
                  TextWidget(
                    main: "SKU Number",
                    value: widget.item.sKU,
                  ),
                  TextWidget(
                    main: "Units",
                    value: widget.item.units.toStringAsFixed(2),
                  ),
                  TextWidget(
                    main: "Ring Size",
                    value: widget.item.ringsize,
                  ),
                  TextWidget(
                    main: "Measurements",
                    value: widget.item.measurements,
                  ),
                  height20Space,
                  Column(
                    children: <Widget>[
                      Text(
                        'CHARGES APPLIED',
                        style: primaryColor18BoldTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'GST',
                            style: black16BoldTextStyle,
                          ),
                          Text(
                            'INR ${(widget.item.amount * (widget.item.charges[1].percentage / 100)).toStringAsFixed(2)}',
                            style: black16BoldTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Divider(
                          thickness: 1,
                          color: blackColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'MINTING',
                            style: black16BoldTextStyle,
                          ),
                          Text(
                            'INR ${(widget.item.amount * (widget.item.charges[2].percentage / 100)).toStringAsFixed(2)}',
                            style: black16BoldTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Divider(
                          thickness: 1,
                          color: blackColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'MAKING CHARGES',
                            style: black16BoldTextStyle,
                          ),
                          Text(
                            'INR ${(widget.item.amount * (widget.item.charges[0].percentage / 100)).toStringAsFixed(2)}',
                            style: black16BoldTextStyle,
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
    );
  }
}

// class Amtcounter extends StatefulWidget {
//   final String amount;
//   Amtcounter({this.amount});
//   @override
//   _AmtcounterState createState() => _AmtcounterState();
// }
//
// class _AmtcounterState extends State<Amtcounter> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }

class TextWidget extends StatelessWidget {
  final String main;
  final String value;
  const TextWidget({Key key, this.main, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          main,
          style: primaryColor18BoldTextStyle,
        ),
        Text(
          value,
          style: black16BoldTextStyle,
        ),
      ],
    );
  }
}
