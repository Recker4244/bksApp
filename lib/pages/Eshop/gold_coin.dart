import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/SingleItemDetail.dart';
import 'package:gold247/models/item.dart';
import 'package:gold247/pages/portfolio/Cart.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/pages/Eshop/itemdetails.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class Goldcoins extends StatefulWidget {
  Goldcoins({this.item});
  List<ItemList> item;

  @override
  _GoldcoinsState createState() => _GoldcoinsState();
}

class _GoldcoinsState extends State<Goldcoins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBgColor,
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2 / 3.2),
            itemCount: widget.item.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Itemdetails(item: widget.item[index]);
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 1,
                          color: blackColor.withOpacity(0.05),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                              ),
                              Image(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(
                                    widget.item[index].item.images[0]),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: scaffoldLightColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(fixPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: double.infinity,
                                ),
                                Text(
                                  '${widget.item[index].grossweight} GRAM ${widget.item[index].composition[0].metalGroup.karatage} GOLD',
                                  style: primaryColor14MediumTextStyle,
                                ),
                                Text(
                                  '${(widget.item[index].composition[0].metalGroup.fineness) / 10}% PURE GOLD ${widget.item[index].item.name}',
                                  style: primaryColor14MediumTextStyle,
                                ),
                                Text(
                                  'INR ${widget.item[index].totalAmount}',
                                  style: black14BoldTextStyle,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
