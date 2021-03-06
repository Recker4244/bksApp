import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/video.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/videoplayer.dart';
import 'package:gold247/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold247/widget/vdo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:sizer/sizer.dart';

//A Map variable to store the complete response

//A List that will store the 'facts' data inside the response
List listOfFacts;

class GuestHome extends StatefulWidget {
  final String language;
  GuestHome({this.language});
  @override
  _GuestHomeState createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  int buyprice;
  int sellprice;
  List Videos;
  List portfolioItems;
  List<Video> howtos;
  List<Video> testimonials;

  buysellprice data = buysellprice();
  Future fetchData() async {
    var request = http.Request('GET',
        Uri.parse('https://goldv2.herokuapp.com/api/buy-sell-price/letest'));

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

  Future fetchVideos(String language) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://goldv2.herokuapp.com/api/video/sort'));
    request.body = json.encode({"language": language, "category": "How To"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      howtos = List<Video>.from(l.map((model) => Video.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return howtos;
  }

  Future fetchtestimonials(String language) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://goldv2.herokuapp.com/api/video/sort'));
    request.body =
        json.encode({"language": language, "category": "Testimonial"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      testimonials = List<Video>.from(l.map((model) => Video.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return testimonials;
  }

  var portfolioItem = [
    {
      'name': 'BTC',
      'image': 'assets/crypto_icon/gold_ingots.png',
      'value': '\$1,45,250',
      'status': 'up',
      'change': '20%',
    },
    {
      'name': 'ETH',
      'image': 'assets/crypto_icon/gold_ingots.png',
      'value': '\$2,50,245',
      'status': 'down',
      'change': '3%',
    }
  ];

  final howToVideo = [
    {
      'link': 'some link',
    },
    {
      'link': 'some link',
    },
    {
      'link': 'some link',
    }
  ];
  Future<bool> init;
  Future<bool> initialise() async {
    await fetchData();
    await fetchVideos(widget.language);
    await fetchtestimonials(widget.language);
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buyGold(String Byprice) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.bottomCenter,
                          child: Login()));
                },

                //TODO : Push to Buy Gold

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    color: scaffoldBgColor.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 8.w,
                            height: 5.h,
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage(goldIngotsPath),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '24 KT GOLD',
                                style: primaryColor18BoldTextStyle,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'BUY RATE:',
                                    style: grey14BoldTextStyle,
                                  ),
                                  Icon(
                                    data.buyChange > 0
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: data.buyChange > 0
                                        ? greenColor
                                        : redColor,
                                  ),
                                  Text(
                                    '${(data.buyChange).abs()}%',
                                    style: black14BoldTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'INR ${Byprice.toString()}', //TODO insert buy price
                        style: black18BoldTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(fixPadding),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10.0),
                    ),
                    color: whiteColor,
                  ),
                  child: Text(
                    'Buy Instant Gold'.toUpperCase(),
                    style: primaryColor16MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    sellGold(String sellprice) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.bottomCenter,
                          child: Login()));
                },

                //TODO : Push to Buy Gold

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    color: scaffoldBgColor.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 8.w,
                            height: 5.h,
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage(goldIngotsPath),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '24 KT GOLD',
                                style: primaryColor18BoldTextStyle,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'SELL RATE:',
                                    style: grey14BoldTextStyle,
                                  ),
                                  Icon(
                                    data.sellChange > 0
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: data.sellChange > 0
                                        ? greenColor
                                        : redColor,
                                  ),
                                  Text(
                                    '${(data.sellChange).abs()}%',
                                    style: black14BoldTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'INR ${sellprice.toString()}', //TODO Sell price
                        style: black18BoldTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(fixPadding),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10.0),
                    ),
                    color: whiteColor,
                  ),
                  child: Text(
                    'Sell Instant Gold'.toUpperCase(),
                    style: primaryColor16MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

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
                    child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ))),
          );
        } else {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: scaffoldBgColor,
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  userGreeting(),
                  activityContainer(),
                  buyGold(data.buy.toStringAsFixed(2)),
                  sellGold(data.sell.toStringAsFixed(2)),
                  howto(),
                  height20Space,
                  test(),
                ],
              ),
            );
          } else {
            return SafeArea(
                child: Scaffold(

                    backgroundColor: scaffoldBgColor,
                    body: Text(
                        " Oops !! Something went wrong "
                    ))
            );
          }
        }
      },
    );
  }

  currentPrice() {
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
                                (item['name'] == 'BTC')
                                    ? Text('${buyprice}')
                                    : Text('${sellprice}'),
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
                        (item['name'] == 'BTC')
                            ? Text('${(buyprice) * 12}')
                            : Text('${(sellprice) * 12}'),
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

  howto() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: fixPadding * 2.0,
            bottom: fixPadding,
          ),
          child: Text(
            "How to",
            style: primaryColor18BoldTextStyle,
          ),
        ),
        Container(
          width: double.infinity,
          height: 178.0,
          child: ListView.builder(
            itemCount: howtos.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // final item = howToVideo[index];

              return GestureDetector(
                onTap: () async {
                  await canLaunch(howtos[index].video)
                      ? await launch(howtos[index].video)
                      : throw 'Could not launch ${howtos[index].video}';
                },
                child: Padding(
                  padding: (index != howtos.length - 1)
                      ? EdgeInsets.only(left: fixPadding * 2.0)
                      : EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      width: 170.0,
                      padding: EdgeInsets.all(fixPadding),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: blackColor.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          VideoDemo2(videolink:howtos[index].video),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                await canLaunch(howtos[index].video)
                                    ? await launch(howtos[index].video)
                                    : throw 'Could not launch ${howtos[index].video}';
                              },
                              child: Icon(Icons.play_circle_outline_rounded,color: scaffoldLightColor,size: 80,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  test() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: fixPadding * 2.0,
            bottom: fixPadding,
          ),
          child: Text(
            "Testimonials",
            style: primaryColor18BoldTextStyle,
          ),
        ),
        Container(
          width: double.infinity,
          height: 178.0,
          child: ListView.builder(
            itemCount: testimonials.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // final item = howToVideo[index];

              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: (index != testimonials.length - 1)
                      ? EdgeInsets.only(left: fixPadding * 2.0)
                      : EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      width: 170.0,
                      padding: EdgeInsets.all(fixPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: blackColor.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          VideoDemo2(videolink:testimonials[index].video),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                await canLaunch(howtos[index].video)
                                    ? await launch(howtos[index].video)
                                    : throw 'Could not launch ${howtos[index].video}';
                              },
                              child: Icon(Icons.play_circle_outline_rounded,color: scaffoldLightColor,size: 80,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

userGreeting() {
  return Padding(
    padding: EdgeInsets.all(fixPadding * 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: grey16BoldTextStyle,
              ),
              heightSpace,
              Text(
                'To My Gold',
                style: black22BoldTextStyle,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            BuildContext context;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomBar(index: 4),
              ),
            );
          },
          borderRadius: BorderRadius.circular(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              'assets/user/guest.PNG',
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}

activityContainer() {
  return Container(
    padding: EdgeInsets.all(fixPadding * 2.0),
    margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: primaryColor,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You Can Do Following',
          style: white16BoldTextStyle,
        ),
        height20Space,
        acitivites("Buy And Save", "Save gold for Long Term Benefits",
            FontAwesomeIcons.calendarCheck),
        height5Space,
        Divider(
          color: whiteColor,
          endIndent: 10,
          indent: 10,
          thickness: 1,
        ),
        height5Space,
        acitivites("Buy Instant Gold", "Save gold for Short Term Benefits",
            FontAwesomeIcons.snowflake),
        height5Space,
        Divider(
          color: whiteColor,
          endIndent: 10,
          indent: 10,
          thickness: 1,
        ),
        height5Space,
        acitivites("Refer and Earn", "Save gold for referring your friends",
            FontAwesomeIcons.shareAlt),
        height5Space,
        Divider(
          color: whiteColor,
          endIndent: 10,
          indent: 10,
          thickness: 1,
        ),
        height5Space,
        acitivites("Save Additional Bonus", "Save additonal bonus on plans",
            FontAwesomeIcons.piggyBank),
        height5Space,
        // Text(
        //   '\$4,50,933',
        //   style: white36BoldTextStyle,
        // ),
        // height20Space,
        // heightSpace,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           'Monthly profit',
        //           style: white16MediumTextStyle,
        //         ),
        //         heightSpace,
        //         Text(
        //           '\$12,484',
        //           style: white26BoldTextStyle,
        //         ),
        //       ],
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(fixPadding * 0.7),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20.0),
        //         color: whiteColor.withOpacity(0.2),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Icon(
        //             Icons.arrow_drop_up,
        //             size: 26.0,
        //             color: whiteColor,
        //           ),
        //           Text(
        //             '+10%',
        //             style: white14MediumTextStyle,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // )
      ],
    ),
  );
}

Container acitivites(String title, String detail, IconData icon) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 35.0,
          height: 35.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: scaffoldBgColor,
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 23,
          ),
        ),
        widthSpace,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title',
                style: white14BoldTextStyle,
              ),
              height5Space,
              Text(
                '$detail',
                style: white14BoldTextStyle,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
