import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/pages/Eshop/eshop.dart';
import 'package:gold247/pages/bottom_bar.dart';
import 'package:gold247/pages/instantGold/sell_gold.dart';
import 'package:gold247/pages/portfolio/Bank_sellRedeem.dart';
import 'package:gold247/pages/portfolio/Cart.dart';

// import 'package:cryptox/pages/instantGold/currency_screen.dart';
import 'package:gold247/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:sizer/sizer.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Withdraw extends StatefulWidget {
  final String balance;
  final String sub;
  const Withdraw({Key key, this.balance, this.sub}) : super(key: key);

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final weightController = TextEditingController();
  final amountController = TextEditingController();
  int endTime;
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

  buysellprice data = buysellprice();
  Future fetchData() async {
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/buy-sell-price/letest'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      data = buysellprice.fromJson(det['data']);
    } else {
      print(response.reasonPhrase);
    }
    return data;
  }

  Future<bool> initialise() async {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 45;
    data = await fetchData();
    return true;
  }

  Future sellSubscription(String subId, String buysellId, String gold) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('${baseurl}/api/sell-subscription/${subId}/${Userdata.id}'));
    request.body =
        json.encode({"buySellId": "${buysellId}", "goldsell": num.parse(gold)});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<bool> init;
  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return FutureBuilder(
      future: init,
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
              backgroundColor: scaffoldBgColor,
              appBar: AppBar(
                backgroundColor: primaryColor,
                titleSpacing: 0.0,
                title: Text(
                  'SELL/REDEEM GOLD',
                  style: TextStyle(
                    color: scaffoldBgColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      '${widget.balance} GRAM',
                      style: black18BoldTextStyle,
                    ),
                    height5Space,
                    Text(
                      'Available Balance',
                      style: black12RegularTextStyle,
                    ),
                    // SizedBox(height: fixPadding * 3.0),
                    ColumnBuilder(
                      itemCount: portfolioItem.length,
                      itemBuilder: (context, index) {
                        final item = portfolioItem[index];
                        return Padding(
                          padding: (index != portfolioItem.length - 1)
                              ? EdgeInsets.fromLTRB(fixPadding * 2.0,
                                  fixPadding * 2.0, fixPadding * 2.0, 0.0)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['name'],
                                              style:
                                                  primaryColor18BoldTextStyle,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Buy Rate',
                                                  style: black12MediumTextStyle,
                                                ),
                                                widthSpace,
                                                Icon(
                                                  data.buyChange > 0
                                                      ? Icons.arrow_drop_up
                                                      : Icons.arrow_drop_down,
                                                  color: data.buyChange > 0
                                                      ? greenColor
                                                      : redColor,
                                                ),
                                                Text(
                                                  '${data.buyChange}%',
                                                  style: black12MediumTextStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "INR ${data.buy.toStringAsFixed(2)}",
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
                    ),
                    myPortfolioItems(),
                    // Amount Textfield Start
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 10.h,
                        //color: Colors.amber,
                        // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                        child: Theme(
                          data: ThemeData(
                            errorColor: primaryColor,
                            primaryColor: whiteColor,
                            textSelectionTheme: TextSelectionThemeData(
                              cursorColor: primaryColor,
                            ),
                          ),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "This field is required";
                              if (num.parse(value) <= 0)
                                return "Weight must be greater than 0";

                              if (num.parse(value) > num.parse(widget.balance))
                                return 'Insufficient balance';
                              return null;
                            },
                            onChanged: (String value) {
                              setState(() {
                                amountController.text =
                                    (double.parse(value) * data.buy)
                                        .toStringAsFixed(2);
                              });
                            },
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            style: primaryColor16MediumTextStyle,
                            decoration: InputDecoration(
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1),
                              ),
                              fillColor: whiteColor,
                              suffix: Text(locale.GRAM,
                                  style: primaryColor16MediumTextStyle),
                              labelText: locale.WeightofGold,
                              labelStyle: primaryColor16MediumTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 40),
                    //   child: Container(
                    //     color: whiteColor,
                    //     // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                    //     child: Theme(
                    //       data: ThemeData(
                    //         primaryColor: whiteColor,
                    //         textSelectionTheme: TextSelectionThemeData(
                    //           cursorColor: primaryColor,
                    //         ),
                    //       ),
                    //       child: TextField(
                    //         controller: weightController,
                    //         keyboardType: TextInputType.number,
                    //         style: primaryColor16MediumTextStyle,
                    //         decoration: InputDecoration(
                    //           labelText: 'Weight',
                    //           labelStyle: TextStyle(
                    //               color: primaryColor,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w600),
                    //           suffix: Text(
                    //             'GRAM',
                    //             style: primaryColor16MediumTextStyle,
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius: const BorderRadius.all(
                    //               const Radius.circular(10.0),
                    //             ),
                    //             borderSide:
                    //                 BorderSide(color: primaryColor, width: 1),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderRadius: const BorderRadius.all(
                    //               const Radius.circular(10.0),
                    //             ),
                    //             borderSide:
                    //                 BorderSide(color: primaryColor, width: 1),
                    //           ),
                    //         ),
                    //         onChanged: (value) {
                    //           setState(() {
                    //             amountController.text =
                    //                 (data.sell *
                    //                         double.parse(weightController.text))
                    //                     .toStringAsFixed(2);
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),

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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 55,

                          // padding: EdgeInsets.only(bottom: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.size,
                                          alignment: Alignment.center,
                                          child: BankDetails(
                                            subscriptionId: widget.sub,
                                            gold: weightController.text,
                                            buysellId:
                                                "615b296904b89d0016b7ad9c",
                                          )));
                                },
                                child: Text(
                                  'sell gold'.toUpperCase(),
                                  style: TextStyle(
                                    color: scaffoldBgColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: whiteColor,
                              ),
                              GestureDetector(
                                onTap: () {
                                  num b = double.parse(amountController.text);
                                  redeemBalance = b.toDouble();
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.size,
                                          alignment: Alignment.center,
                                          child: BottomBar(
                                            index: 3,
                                          )));
                                },
                                child: Text(
                                  'redeem gold'.toUpperCase(),
                                  style: TextStyle(
                                    color: scaffoldBgColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    height5Space,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountdownTimer(
                        onEnd: () async {
                          data = await fetchData();
                          if (mounted)
                            setState(() {
                              endTime = DateTime.now().millisecondsSinceEpoch +
                                  1000 * 45;
                            });
                        },
                        endTime: endTime,
                        widgetBuilder: (BuildContext context, C) {
                          if (C == null) {
                            return Text('Price changing..',
                                style: black18BoldTextStyle);
                          }
                          return Text(
                              "You have ${C.min == null ? 0 : C.min}:${C.sec} minutes",
                              style: black18BoldTextStyle);
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "You can also prefer to partly sell or redeem by entering your preferred weight",
                            textAlign: TextAlign.center,
                            style: black14SemiBoldTextStyle,
                          ),
                        ],
                      ),
                    )
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
                                Icon(
                                  data.sellChange > 0
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: data.sellChange > 0
                                      ? greenColor
                                      : redColor,
                                ),
                                Text(
                                  '${data.sellChange}%',
                                  style: black12MediumTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "INR ${data.sell.toStringAsFixed(2)}",
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
