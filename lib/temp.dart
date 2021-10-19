import 'package:gold247/constant/constant.dart';
import 'package:gold247/pages/market/all_coins.dart';

import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';

////TODO     market

class Market extends StatefulWidget {
  const Market({Key key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Market is up 2.06% today',
            style: TextStyle(
              fontSize: 16.0,
              color: greenColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: primaryColor,
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Running'),
              Tab(text: 'Forfieted'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            All(),
            Running(),
            //Forfieted(),
            Completed(),
          ],
        ),
      ),
    );
  }
}
