import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/Eshop/eshop.dart';
import 'package:gold247/pages/currencyScreen/sell_gold.dart';
import 'package:gold247/pages/profile/bank_details.dart';
import 'package:gold247/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Buy_plan extends StatefulWidget {
  const Buy_plan({Key key}) : super(key: key);

  @override
  _Buy_planState createState() => _Buy_planState();
}

class _Buy_planState extends State<Buy_plan> {
  final weightController = TextEditingController();
  final amountController = TextEditingController();
  final portfolioItem = [
    {
      'name': '24 KT GOLD',
      'shortName': 'BTC',
      'image': 'assets/crypto_icon/gold_ingots.png',
      'value': 'INR 4,380.00',
      'status': 'down',
      'change': '0.00%',
      'coinTotal': 'Sell Rate'
    }
  ];
  @override
  void initState() {
    super.initState();
    setState(() {
      weightController.text = '13.20';
      amountController.text = '57,816';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          'BUY GOLD',
          style: TextStyle(
            color: scaffoldBgColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '13.20 GRAM',
            style: black18BoldTextStyle,
          ),
          height5Space,
          Text(
            'Available Balance',
            style: black12RegularTextStyle,
          ),
          // SizedBox(height: fixPadding * 3.0),
          myPortfolioItems(),
          // Amount Textfield Start
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
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
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
          ),

          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
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
                    labelText: 'Amount',
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
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
          ),

          SizedBox(height: fixPadding * 3.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 55,

                // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.center,
                            child: BankDetails()));
                  },
                  child: Text(
                    'sell gold'.toUpperCase(),
                    style: TextStyle(
                      color: scaffoldBgColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          height5Space,
          Text(
            'You have 0:43 Minutes',
            style: black14SemiBoldTextStyle,
          ),
        ],
      ),
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
              : EdgeInsets.all(fixPadding * 2.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    item['image'],
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                  ),
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
                              style: primaryColor18BoldTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${item['coinTotal']}',
                                  style: black12MediumTextStyle,
                                ),
                                widthSpace,
                                (item['status'] == 'up')
                                    ? Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.arrow_drop_down,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                Text(
                                  item['change'],
                                  style: black12MediumTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          item['value'],
                          style: black16BoldTextStyle,
                        ),
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
