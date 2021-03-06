import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/BuySellprice.dart';
import 'package:gold247/models/cycle.dart';
import 'package:gold247/pages/home/byValue_ProceedF.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'byWght_ProceddF.dart';

class ByValue_Wght extends StatefulWidget {
  ByValue_Wght(this.plantype);

  final String plantype;

  @override
  _ByValue_WghtState createState() => _ByValue_WghtState();
}

class _ByValue_WghtState extends State<ByValue_Wght> {
  final valueController = TextEditingController();
  final amountController = TextEditingController();
  final plancontroller = TextEditingController();
  final DurationController = TextEditingController();
  Future<bool> init;
  String CyclePController;
  List price;
  int buyprice;
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

  Future<bool> initialise() async {
    temp = await getcycles();
    await fetchData();
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    return true;
  }

  List<cycles> temp = [];
  Future getcycles() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/cycle-period'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Iterable l = jsonDecode(responseString);
      temp = List<cycles>.from(l.map((model) => cycles.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return temp;
  }

  String cyclesname(String id) {
    for (int i = 0; i < temp.length; i++) {
      if (temp[i].sId == id) {
        String res = temp[i].name == 'Every Month'
            ? 'Months'
            : temp[i].name == 'Every Day'
                ? 'Days'
                : 'Week';
        return res;
      }
    }
  }

  String getcyclename(String id) {
    for (int i = 0; i < temp.length; i++) {
      if (temp[i].sId == id) {
        return temp[i].name;
      }
    }
  }

  getShort(String id) {
    for (int i = 0; i < temp.length; i++) {
      if (temp[i].sId == id) {
        return temp[i].shortName;
      }
    }
  }

  int calc() {
    return int.parse(valueController.text) * buyprice;
  }

  // var CyclePeriod = ["Every Day", "Every Week", "Every Bi-week", "Every Month"];

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  int endTime;
  @override
  Widget build(BuildContext context) {
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
              return SafeArea(
                  child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: whiteColor,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: primaryColor,
                  centerTitle: true,
                  title: Text(
                    widget.plantype,
                    style: white18MediumTextStyle,
                  ),
                ),
                bottomNavigationBar: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: ByValFlexi(
                                gold: double.parse(valueController.text),
                                val: (double.parse(valueController.text) /
                                    data.buy),
                                duration: int.parse(DurationController.text),
                                CycleP: CyclePController,
                                planname:
                                    "${DurationController.text} ${cyclesname(CyclePController)} Flexi Value Plan ",
                                mode: 1,
                                shortName: getShort(CyclePController))));
                  },
                  child: Container(
                    color: primaryColor,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    height: 50.0,
                    padding: EdgeInsets.all(fixPadding * 1.5),
                    child: Text(
                      'Proceed For Payment',
                      style: white18BoldTextStyle,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(fixPadding * 1.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                          ),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: blackColor.withOpacity(0.05),
                              spreadRadius: 4,
                              blurRadius: 4,
                            ),
                          ],
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
                                  width: 50.0,
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(goldIngotsPath),
                                  ),
                                ),
                                widthSpace,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '24 KT GOLD',
                                      style: primaryColor18BoldTextStyle,
                                    ),
                                    height5Space,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          '${data.buyChange.abs()}%',
                                          style: black14BoldTextStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              'INR ${data.buy}',
                              style: black18BoldTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CountdownTimer(
                          onEnd: () async {
                            data = await fetchData();
                            if (mounted)
                              setState(() {
                                endTime =
                                    DateTime.now().millisecondsSinceEpoch +
                                        1000 * 30;
                              });
                          },
                          endTime: endTime,
                          widgetBuilder: (BuildContext context, C) {
                            if (C == null) {
                              return Text('Price changing..',
                                  style: black18BoldTextStyle);
                            }
                            return Text(
                                "Price Changes in ${C.min == null ? 0 : C.min}:${C.sec} minutes",
                                style: black18BoldTextStyle);
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(fixPadding * 2),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: whiteColor,
                              ),
                              child: TextField(
                                onChanged: (String value) {
                                  setState(() {
                                    amountController.text =
                                        (int.parse(value) / data.buy)
                                            .toStringAsFixed(2);
                                  });
                                },
                                controller: valueController,
                                keyboardType: TextInputType.number,
                                style: primaryColor18BoldTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                  labelStyle: primaryColor18BoldTextStyle,
                                  suffix: Text(
                                    'INR',
                                    style: primaryColor18BoldTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(fixPadding * 2),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                              ),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Cycle Period',
                                      labelStyle: primaryColor18BoldTextStyle,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 0.7),
                                      ),
                                    ),
                                    isEmpty: CyclePController == '',
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: CyclePController,
                                        isDense: true,
                                        style: primaryColor16MediumTextStyle,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            CyclePController = newValue;

//state.didChange(newValue);
                                          });
                                        },
                                        items: temp.map((cycles period) {
                                          return DropdownMenuItem<String>(
                                            value: period.sId,
                                            child: Text(period.name),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(fixPadding * 2),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                              ),
                              child: TextField(
                                controller: DurationController,
                                keyboardType: TextInputType.number,
                                style: primaryColor18BoldTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Duration',
                                  labelStyle: primaryColor18BoldTextStyle,
                                  suffix: Text(
                                    getcyclename(CyclePController) ==
                                            'Every Month'
                                        ? 'Months'
                                        : getcyclename(CyclePController) ==
                                                'Every Day'
                                            ? 'Days'
                                            : 'Week',
                                    style: primaryColor18BoldTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(fixPadding * 2),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                              ),
                              child: TextField(
                                enabled: false,
                                controller: amountController,
                                keyboardType: TextInputType.text,
                                style: primaryColor18BoldTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Weight of Gold',
                                  labelStyle: primaryColor18BoldTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
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
  }
}
