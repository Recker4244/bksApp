import 'package:gold247/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:gold247/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  List Data;
  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse('https://goldv2.herokuapp.com/api/buy-sell-price'));
    if (response.statusCode == 200) {
      setState(() {
        Data = json.decode(response.body);
      });
    }
  }

  final portfolioItem = [
    {
      'name': '24 KT GOLD',
      'shortName': 'BTC',
      'image': 'assets/crypto_icon/gold_ingots.png',
      'value': 'INR 4,580.00',
      'status': 'up',
      'change': '11.0%',
      'coinTotal': 'Buy Rate'
    }
  ];

  @override
  void initState() {
    fetchData();
    super.initState();
    setState(() {
      weightController.text = '1.00';
      amountController.text = '4,580';
    });
  }

  // final planDetails = [
  //   {'title': 'jhggjh', 'value': 'dasasd'},
  //   {'title': 'jhggjh', 'value': 'dasasd'},
  //   {'title': 'jhggjh', 'value': 'dasasd'},
  //   {'title': 'jhggjh', 'value': 'dasasd'},
  // ];
  final weightController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        title: Text(
          '12 Months Standard Weight Plan',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: scaffoldBgColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              child: Container(
                // width: double.infinity,
                height: 100,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                // height: double.infinity,
                child: myPortfolioItems(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: whiteColor,
                    // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: whiteColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        style: primaryColor16MediumTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Weight',
                          labelStyle: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          suffix: Text(
                            'GRAM',
                            style: primaryColor16MediumTextStyle,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(height: 17),
                  Text(
                    "Plan Details",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 17),
                  Column(
                    children: [
                      details('Saving Gold', '1 GRAM/month',
                          'Bonus By Maturity', '1.2 GRAM'),
                      SizedBox(height: 8),
                      details(
                          'Duration', '12 Months', 'Total Saving', '13.2 GRAM'),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    color: whiteColor,
                    // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: whiteColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        style: primaryColor16MediumTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Amount To Be Paid',
                          labelStyle: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          suffix: Text(
                            'INR',
                            style: primaryColor16MediumTextStyle,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(height: 42),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 60,

                      // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'save now'.toUpperCase(),
                            style: TextStyle(
                              color: scaffoldBgColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Container(
                          //   height: 30.0,
                          //   width: 1.0,
                          //   color: whiteColor,
                          // ),
                          // Text(
                          //   'redeem gold'.toUpperCase(),
                          //   style: TextStyle(
                          //     color: scaffoldBgColor,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  heightSpace,
                  Center(
                    child: Text(
                      'Price Changes in 0:43 Minutes',
                      style: black14SemiBoldTextStyle,
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

  Row details(String title1, String amount1, String title2, String amount2) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    '$title1',
                    style: grey14BoldTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                  child: Text(
                    '$amount1',
                    style: black14BoldTextStyle,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    '$title2',
                    style: grey14BoldTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                  child: Text(
                    '$amount2',
                    style: black14BoldTextStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  myPortfolioItems() {
    return ColumnBuilder(
      itemCount: portfolioItem.length,
      itemBuilder: (context, index) {
        final item = portfolioItem[index];
        return Padding(
          padding: (index != portfolioItem.length - 1)
              ? EdgeInsets.fromLTRB(
                  fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0)
              : EdgeInsets.all(fixPadding),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: whiteColor,
                // boxShadow: [
                //   BoxShadow(
                //     blurRadius: 4.0,
                //     spreadRadius: 1.0,
                //     color: blackColor.withOpacity(0.05),
                //   ),
                // ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    item['image'],
                    height: 38.0,
                    width: 38.0,
                    fit: BoxFit.cover,
                  ),
                  widthSpace,
                  widthSpace,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: grey14BoldTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${item['coinTotal']}',
                                  style: black16SemiBoldTextStyle,
                                ),
                                widthSpace,
                                (item['status'] == 'up')
                                    ? Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.green,
                                        size: 35,
                                      )
                                    : Icon(
                                        Icons.arrow_drop_down,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                Text(
                                  item['change'],
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: blackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Text(
                        //   item['value'],
                        //   style: black16BoldTextStyle,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
