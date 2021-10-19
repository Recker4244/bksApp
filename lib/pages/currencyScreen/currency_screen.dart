import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key key}) : super(key: key);

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  bool watchlist = false;
  final valueController = TextEditingController();
  final amountController = TextEditingController();

  final sellValueController = TextEditingController();
  final sellAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
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
              InkWell(
                onTap: () => buyBottomSheet(),
                child: Container(
                  height: 50.0,
                  width: (width - 1.0) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    'SELL BY VALUE'.toUpperCase(),
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
                onTap: () => sellBottomSheet(),
                child: Container(
                  height: 50.0,
                  width: (width - 1.0) / 2,
                  alignment: Alignment.center,
                  child: Text(
                    'SELL BY WEIGHT'.toUpperCase(),
                    style: white16BoldTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            currencyPriceChart(),
            aboutPortfolio(),
          ],
        ),
      ),
    );
  }

  currencyPriceChart() {
    return Container(
      color: whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                    ),
                    widthSpace,
                    Text(
                      'BTC',
                      style: black16BoldTextStyle,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      watchlist = !watchlist;
                    });
                    if (watchlist) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Added to watchlist'),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Remove from watchlist'),
                      ));
                    }
                  },
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    width: 36.0,
                    height: 36.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        width: 0.6,
                        color: primaryColor.withOpacity(0.6),
                      ),
                    ),
                    child: Icon(
                      (watchlist) ? Icons.star : Icons.star_border,
                      size: 24.0,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 56.0,
                  width: 56.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                      width: 0.8,
                      color: greyColor.withOpacity(0.5),
                    ),
                  ),
                  child: Image.asset(
                    'assets/crypto_icon/btc.png',
                    width: 36.0,
                    height: 36.0,
                    fit: BoxFit.cover,
                  ),
                ),
                widthSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current BTC Buy Price',
                      style: black14RegularTextStyle,
                    ),
                    height5Space,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$39,914',
                          style: black18SemiBoldTextStyle,
                        ),
                        widthSpace,
                        Icon(
                          Icons.arrow_drop_up,
                          size: 26.0,
                          color: primaryColor,
                        ),
                        Text(
                          '4.65%',
                          style: primaryColor16MediumTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          height20Space,
          Container(
            width: double.infinity,
            height: 250.0,
            child: CryptoChartSyncfusion(),
          ),
        ],
      ),
    );
  }

  aboutPortfolio() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Portfolio',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              aboutPortfolioItem('BTC Balance', '5.0107731'),
              aboutPortfolioItem('Current Value', '\$200,005'),
            ],
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              aboutPortfolioItem('Average Buy Price', '\$37,598'),
              Container(
                height: 75.0,
                width: (width - fixPadding * 6.0) / 2,
                padding: EdgeInsets.all(fixPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      color: blackColor.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gain/Loss',
                      style: grey14MediumTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_drop_up,
                          size: 26.0,
                          color: primaryColor,
                        ),
                        Text(
                          '5.65%',
                          style: primaryColor16BoldTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  aboutPortfolioItem(title, value) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 75.0,
      width: (width - fixPadding * 6.0) / 2,
      padding: EdgeInsets.all(fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 1.0,
            color: blackColor.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: grey14MediumTextStyle,
          ),
          Text(
            value,
            style: black16BoldTextStyle,
          ),
        ],
      ),
    );
  }

  aboutItem(iconPath, title, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    width: 16.0,
                    height: 16.0,
                    fit: BoxFit.cover,
                  ),
                  width5Space,
                  Text(
                    title,
                    style: black14RegularTextStyle,
                  ),
                ],
              ),
              Text(
                value,
                style: black14MediumTextStyle,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.7,
          color: greyColor.withOpacity(0.4),
        ),
      ],
    );
  }

  void buyBottomSheet() {
    double bitcoinPrice = 39914;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: scaffoldBgColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            'Buy 24 KT GOLD By Value',
                            style: primaryColor18BoldTextStyle,
                          ),
                        ),
                        height20Space,
                        Container(
                          width: double.infinity,
                          height: 0.9,
                          color: primaryColor,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 56.0,
                                width: 56.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(7.0),
                                  // border: Border.all(
                                  //   width: 0.8,
                                  //   color: greyColor.withOpacity(0.5),
                                  // ),
                                ),
                                child: Image.asset(
                                  'assets/crypto_icon/gold_ingots.png',
                                  width: 36.0,
                                  height: 36.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              widthSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current 24 KT GOLD Buy Price',
                                    style: grey14BoldTextStyle,
                                  ),
                                  height5Space,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'INR 4,714.40',
                                        style: black18SemiBoldTextStyle,
                                      ),
                                      widthSpace,
                                      // Icon(
                                      //   Icons.arrow_drop_up,
                                      //   size: 26.0,
                                      //   color: primaryColor,
                                      // ),
                                      Text(
                                        '(GST 3% Included)',
                                        style: black14BoldTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Enter Value Textfield
                        Container(
                          color: whiteColor,
                          child: TextField(
                            controller: valueController,
                            keyboardType: TextInputType.number,
                            style: black16BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Enter Value',
                              labelStyle: black16BoldTextStyle,
                              suffix: Text(
                                'INR',
                                style: black16BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            onChanged: (value) {
                              var val = int.parse('${valueController.text}');
                              var amount =
                                  (val / bitcoinPrice).toStringAsFixed(4);
                              setState(() {
                                amountController.text = '$amount';
                              });
                            },
                          ),
                        ),

                        height20Space,

                        // Amount Textfield
                        Container(
                          color: whiteColor,
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: black16BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Weight Comes Here',
                              labelStyle: black16BoldTextStyle,
                              suffix: Text(
                                'GRAM',
                                style: black16BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        height20Space,
                        // Buy Button
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.topToBottom,
                                child: BuySuccessScreen(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(fixPadding * 1.7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'Buy'.toUpperCase(),
                              style: TextStyle(
                                color: scaffoldBgColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void sellBottomSheet() {
    double bitcoinPrice = 39914;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: scaffoldBgColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            'Buy 24 KT GOLD By Weight',
                            style: primaryColor18BoldTextStyle,
                          ),
                        ),
                        height20Space,
                        Container(
                          width: double.infinity,
                          height: 0.9,
                          color: primaryColor,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 56.0,
                                width: 56.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: whiteColor,
                                  // border: Border.all(
                                  //   width: 0.8,
                                  //   color: greyColor.withOpacity(0.5),
                                  // ),
                                ),
                                child: Image.asset(
                                  'assets/crypto_icon/gold_ingots.png',
                                  width: 36.0,
                                  height: 36.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              widthSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current 24 KT GOLD Buy Price',
                                    style: grey14BoldTextStyle,
                                  ),
                                  height5Space,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'INR 4,714.40',
                                        style: black18SemiBoldTextStyle,
                                      ),
                                      widthSpace,
                                      // Icon(
                                      //   Icons.arrow_drop_up,
                                      //   size: 26.0,
                                      //   color: primaryColor,
                                      // ),
                                      Text(
                                        '(GST 3% Included)',
                                        style: black14BoldTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Enter Value Textfield
                        Container(
                          color: whiteColor,
                          child: TextField(
                            controller: sellValueController,
                            keyboardType: TextInputType.number,
                            style: black16BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Enter Weight',
                              labelStyle: black16BoldTextStyle,
                              suffix: Text(
                                'GRAM',
                                style: black16BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            onChanged: (value) {
                              var val =
                                  int.parse('${sellValueController.text}');
                              var amount =
                                  (val / bitcoinPrice).toStringAsFixed(4);
                              setState(() {
                                sellAmountController.text = '$amount';
                              });
                            },
                          ),
                        ),

                        height20Space,

                        // Amount Textfield
                        Container(
                          color: whiteColor,
                          child: TextField(
                            controller: sellAmountController,
                            keyboardType: TextInputType.number,
                            style: black16BoldTextStyle,
                            decoration: InputDecoration(
                              labelText: 'Amout Comes Here',
                              labelStyle: black16BoldTextStyle,
                              suffix: Text(
                                'INR',
                                style: black16BoldTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        height20Space,
                        // Buy Button
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.topToBottom,
                                child: BuySuccessScreen(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(fixPadding * 1.7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'buy'.toUpperCase(),
                              style: TextStyle(
                                color: scaffoldBgColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
