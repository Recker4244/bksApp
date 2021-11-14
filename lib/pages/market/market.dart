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
                    child: CircularProgressIndicator(
                  color: primaryColor,
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
                  automaticallyImplyLeading: true,
                  bottom: TabBar(
                    isScrollable: true,
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
