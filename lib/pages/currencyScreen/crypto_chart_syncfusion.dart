import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellList.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class CryptoChartSyncfusion extends StatefulWidget {
  CryptoChartSyncfusion({@required this.type});
  final String type;
  @override
  _CryptoChartSyncfusionState createState() => _CryptoChartSyncfusionState();
}

class _CryptoChartSyncfusionState extends State<CryptoChartSyncfusion> {
  List<BuySellList> buyselllist = [];
  getallbuysell() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/buy-sell-price'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      List det = jsonDecode(responseString);
      Iterable l = det;
      buyselllist =
          List<BuySellList>.from(l.map((e) => BuySellList.fromJson(e)));
    } else {
      print(response.reasonPhrase);
    }
  }

  List<SalesData> chartData = [];
  void buidchartforsell() async {
    await getallbuysell();
    for (int i = 0; i < buyselllist.length; i++) {
      print(buyselllist[i].sell);
      chartData.add(SalesData(i, double.parse(buyselllist[i].sell.toString())));
    }
    print(chartData);
  }

  void buidchart(String type) async {
    await getallbuysell();
    if (type == "buy") {
      for (int i = 0; i < buyselllist.length; i++) {
        print(buyselllist[i].buy);
        chartData
            .add(SalesData(i, double.parse(buyselllist[i].buy.toString())));
      }
    } else {
      for (int i = 0; i < buyselllist.length; i++) {
        print(buyselllist[i].sell);
        chartData
            .add(SalesData(i, double.parse(buyselllist[i].sell.toString())));
      }
    }

    print(chartData);
  }

  Future<bool> init;
  Future<bool> initialise() async {
    await buidchart(widget.type);
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    final List<double> stops = <double>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[100]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue[300]);
    color.add(Colors.blue[400]);
    color.add(Colors.blue[500]);
    color.add(Colors.blue[600]);
    color.add(Colors.blue[700]);
    color.add(Colors.blue[800]);
    color.add(Colors.blue[900]);

    stops.add(0.1);
    stops.add(0.2);
    stops.add(0.3);
    stops.add(0.4);
    stops.add(0.5);
    stops.add(0.6);
    stops.add(0.7);
    stops.add(0.8);
    stops.add(0.9);
    stops.add(1.0);
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
                    color: primaryColor,
                  ))),
            );
          } else {
            if (snapshot.hasData) {
              final LinearGradient gradientColors =
                  LinearGradient(colors: color, stops: stops);
              return Container(
                color: scaffoldBgColor,
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    // Renders area chart
                    AreaSeries<SalesData, double>(
                        dataSource: chartData,
                        xValueMapper: (SalesData sales, _) =>
                            double.parse(sales.xaxis.toString()),
                        yValueMapper: (SalesData sales, _) => sales.yaxis,
                        gradient: gradientColors),
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
        });

    // chartData.add(SalesData(0,double.parse(buyselllist[0].buy.toString())));
    // chartData.add(SalesData(1,double.parse(buyselllist[1].buy.toString())));
    // chartData.add(SalesData(2,double.parse(buyselllist[2].buy.toString())));
  }
}

class SalesData {
  SalesData(this.xaxis, this.yaxis);

  final int xaxis;
  final double yaxis;
}
