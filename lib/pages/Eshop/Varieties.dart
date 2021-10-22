import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/collection.dart';
import 'package:gold247/models/variety.dart';
import 'package:gold247/pages/Eshop/Products.dart';
import 'package:gold247/pages/screens.dart';
import 'package:gold247/pages/Eshop/itemdetails.dart';
import 'package:gold247/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/language/locale.dart';
import 'Categories.dart';

class Varieties extends StatefulWidget {
  @override
  _VarietiesState createState() => _VarietiesState();
}

class _VarietiesState extends State<Varieties> {
  List<variety> temp;
  Future getvarieties() async {
    var request = http.Request(
        'GET', Uri.parse('https://goldv2.herokuapp.com/api/variety/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['varieties'];
      temp = List<variety>.from(l.map((model) => variety.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return temp;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getvarieties(),
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
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: whiteColor,
                    title: Text(
                      'Varieties',
                      style: primaryColor18BoldTextStyle,
                    ),
                  ),
                  backgroundColor: scaffoldBgColor,
                  body: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(fixPadding),
                          child: Reusablecard2(
                            name: temp[index].varietyName,
                            Imageurl: [
                              temp[index].img1,
                              temp[index].img2,
                              temp[index].img3
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: temp.length,
                  )),
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

class Reusablecard2 extends StatelessWidget {
  Reusablecard2({this.name, this.Imageurl});
  final String name;
  final List<String> Imageurl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Products();
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 1,
              color: blackColor.withOpacity(0.05),
            ),
          ],
        ),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: Imageurl.length,
              itemBuilder: (context, Index, realIndex) {
                final imgurl = Imageurl[Index];
                return buildImage(imgurl, Index);
              },
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(fixPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      name,
                      style: primaryColor14MediumTextStyle,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String url, int Index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            )),
      );
}
