import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/customSub.dart';
import 'package:gold247/models/standardSub.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
////TODO     market

class Market extends StatefulWidget {
  const Market({Key key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  List<subscription> temp;
  List<subscription> running;
  List<subscription> forfeited;
  List<subscription> complete;
  skip() {}
  Future getplans() async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/subscription/user/${Userdata.id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      List dat = det['data'];
      List<subscription> subs = [];
      for (int j = 0; j < dat.length; j++) {
        if (dat[j]['plan'] == null) {
          customSub sub = customSub.fromJson(dat[j]);
          subs.add(Custom(sub));
        } else {
          standardSub sub = standardSub.fromJson(dat[j]);
          subs.add(Standard(sub));
        }
      }
      temp = subs;

      running = temp.where((item) => item.status() == "Running").toList();
      forfeited = temp.where((item) => item.status() == "Forfeited").toList();
      complete = temp.where((item) => item.status() == "Completed").toList();
    } else {
      print(response.reasonPhrase);
    }

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getplans(),
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
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  backgroundColor: whiteColor,
                  automaticallyImplyLeading: false,
                  title: Text('Total gold saved in plans',
                      style: primaryColor22BoldTextStyle),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF95203D),
                      size: 32.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  bottom: const TabBar(
                    labelColor: Colors.grey,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    indicatorColor: primaryColor,
                    tabs: [
                      Tab(text: 'Running'),
                      Tab(text: 'Forfieted'),
                      Tab(text: 'Completed'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Running(
                      running: running,
                    ),
                    Forfeited(
                      forfeited: forfeited,
                    ),
                    Completed(
                      completed: complete,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SafeArea(
                child: Scaffold(
                    backgroundColor: scaffoldBgColor,
                    body: Text(" Oops !! Something went wrong ")));
          }
        }
      },
    );
  }
}
