import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/category.dart';
import 'package:gold247/models/collection.dart';
import 'package:gold247/models/product.dart';
import 'package:gold247/models/variety.dart';
import 'package:gold247/pages/Eshop/eshop.dart';
import 'package:gold247/videoplayer.dart';
import 'package:gold247/language/locale.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ItemsCat extends StatefulWidget {
  @override
  _ItemsCatState createState() => _ItemsCatState();
}

class _ItemsCatState extends State<ItemsCat> {
  List<category> categoryList;
  Future getcategories() async {
    var request = http.Request('GET', Uri.parse('${baseurl}/api/category/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['categories'];
      categoryList =
          List<category>.from(l.map((model) => category.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return categoryList;
  }

  List<product> productList;
  Future getproducts() async {
    var request = http.Request('GET', Uri.parse('${baseurl}/api/product/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      List det = jsonDecode(responseString);
      Iterable l = det;
      productList =
          List<product>.from(l.map((model) => product.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return productList;
  }

  List<variety> varietyList;
  Future getvarieties() async {
    var request = http.Request('GET', Uri.parse('${baseurl}/api/variety/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['varieties'];
      varietyList =
          List<variety>.from(l.map((model) => variety.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return varietyList;
  }

  List<collection> collectionList;
  Future getCollections() async {
    var request = http.Request('GET', Uri.parse('${baseurl}/api/collection/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['collections'];
      collectionList =
          List<collection>.from(l.map((model) => collection.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
    return collectionList;
  }

  Future<bool> init() async {
    await getCollections();
    await getcategories();
    await getvarieties();
    await getproducts();
    return true;
  }

  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return FutureBuilder(
      future: init(),
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
                    title: Center(
                      child: Text(
                        locale.shoptitle,
                        style: primaryColor18BoldTextStyle,
                      ),
                    ),
                  ),
                  backgroundColor: scaffoldBgColor,
                  body: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        height: 37.h,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 20.h,
                                child: Padding(
                                    padding: const EdgeInsets.all(fixPadding),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Eshop(
                                                      id: productList[index]
                                                          .sId,
                                                      type: "product",
                                                    )));
                                      },
                                      child: previewCard(
                                        name: productList[index].name,
                                        id: productList[index].sId,
                                        images: productList[index].images,
                                        video: productList[index].video,
                                      ),
                                    )),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        locale.collectionss,
                        style: primaryColor16MediumTextStyle,
                      ),
                      heightSpace,
                      Container(
                        height: 33.h,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Padding(
                                    padding: const EdgeInsets.all(fixPadding),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Eshop(
                                                      id: collectionList[index]
                                                          .sId,
                                                      type: "collections",
                                                    )));
                                      },
                                      child: CollectionCard(
                                        name: collectionList[index]
                                            .collectionName,
                                        id: collectionList[index].sId,
                                        img1: collectionList[index].img1,
                                        img2: collectionList[index].img2,
                                        img3: collectionList[index].img3,
                                        video: collectionList[index].video,
                                      ),
                                    )),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: collectionList.length,
                        ),
                      ),
                      height20Space,
                      Text(
                        locale.categories,
                        style: primaryColor16MediumTextStyle,
                      ),
                      heightSpace,

                      Container(
                        height: 40.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 3),
                              itemCount: categoryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Eshop(
                                                  id: categoryList[index].sId,
                                                  type: "category",
                                                )));
                                  },
                                  child: CategoryCard(
                                    name: categoryList[index].categoryName,
                                    id: categoryList[index].sId,
                                    img1: categoryList[index].img1,
                                    img2: categoryList[index].img2,
                                    img3: categoryList[index].img3,
                                    video: categoryList[index].video,
                                  ),
                                );
                              }),
                        ),
                      ),
                      //height20Space,
                      Text(
                        locale.OurVarieties,
                        style: primaryColor16MediumTextStyle,
                      ),
                      heightSpace,
                      Container(
                        height: 50.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 3),
                              itemCount: varietyList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Eshop(
                                                    id: varietyList[index].sId,
                                                    type: "variety",
                                                  )));
                                    },
                                    child: varietyCard(
                                      id: varietyList[index].sId,
                                      name: varietyList[index].varietyName,
                                      img1: varietyList[index].img1,
                                      img2: varietyList[index].img2,
                                      img3: varietyList[index].img3,
                                      video: varietyList[index].video,
                                    ));
                              }),
                        ),
                      ),
                      height20Space,
                    ],
                  ))),
            );
          } else {
            return SafeArea(
                child: Scaffold(
                    backgroundColor: scaffoldBgColor,
                    body: Center(
                      child: Text(" Oops !! No Items found "),
                    )));
          }
        }
      },
    );
  }
}

class varietyCard extends StatefulWidget {
  final String name;
  final String id;
  final String img1;
  final String img2;
  final String img3;
  final String video;

  varietyCard(
      {this.name, this.id, this.img1, this.img2, this.img3, this.video});

  @override
  _varietyCardState createState() => _varietyCardState();
}

class _varietyCardState extends State<varietyCard> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [widget.img1, widget.img2, widget.img3];
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10.0),
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
                itemCount: 4,
                itemBuilder: (context, Index, realIndex) {
                  if (Index <= 2) {
                    return Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              images[Index] != null
                                  ? images[Index]
                                  : Placeholder(),
                            ),
                          )),
                    );
                  }
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: VideoDemo(
                        videolink: widget.video,
                      ));
                },
                options: CarouselOptions(
                  height: 30.h,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Container(
                padding: EdgeInsets.all(fixPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class CategoryCard extends StatefulWidget {
  final String name;
  final String id;
  final String img1;
  final String img2;
  final String img3;
  final String video;

  CategoryCard(
      {this.name, this.id, this.img1, this.img2, this.img3, this.video});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [widget.img1, widget.img2, widget.img3];
    return Container(
      height: 20.h,
      decoration: BoxDecoration(
        color: primaryColor,
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
            itemCount: 4,
            itemBuilder: (context, Index, realIndex) {
              if (Index <= 2) {
                return Container(
                  width: 55.w,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          images[Index] != null ? images[Index] : Placeholder(),
                        ),
                      )),
                );
              }
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: VideoDemo(
                    videolink: widget.video,
                  ));
            },
            options: CarouselOptions(
              height: 30.h,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            padding: EdgeInsets.all(fixPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                ),
                Text(
                  widget.name,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class previewCard extends StatefulWidget {
  final String name;
  final String id;
  final List<String> images;
  final String video;

  previewCard({this.name, this.id, this.images, this.video});

  @override
  _previewCardState createState() => _previewCardState();
}

class _previewCardState extends State<previewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 27.h,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: widget.images.length,
            itemBuilder: (context, Index, realIndex) {
              return Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(
                        widget.images[Index] != null
                            ? widget.images[Index]
                            : Placeholder(),
                      ),
                    )),
              );
            },
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            padding: EdgeInsets.all(fixPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                ),
                Text(
                  widget.name,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CollectionCard extends StatefulWidget {
  final String name;
  final String id;
  final String img1;
  final String img2;
  final String img3;
  final String video;

  CollectionCard(
      {this.name, this.id, this.img1, this.img2, this.img3, this.video});

  @override
  _CollectionCardState createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [widget.img1, widget.img2, widget.img3];
    return Container(
      width: 80.w,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 4,
            itemBuilder: (context, Index, realIndex) {
              if (Index <= 2) {
                return Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          images[Index] != null ? images[Index] : Placeholder(),
                        ),
                      )),
                );
              }
              return Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: VideoDemo(
                    videolink: widget.video,
                  ));
            },
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            padding: EdgeInsets.all(fixPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                ),
                Text(
                  widget.name,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
