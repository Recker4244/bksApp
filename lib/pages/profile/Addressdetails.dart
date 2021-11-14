import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/UserAddress.dart';
import 'package:gold247/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gold247/language/locale.dart';
import 'package:sizer/sizer.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({Key key}) : super(key: key);

  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  List<UserAddress> list_of_address = [];
  void getAddressDetails() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/address/user/${Userdata.id}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable l = det['data'];
      list_of_address =
          List<UserAddress>.from(l.map((model) => UserAddress.fromJson(model)));
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<bool> init;
  Future<bool> initialise() async {
    await getAddressDetails();
    return true;
  }

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
                      child: CircularProgressIndicator(
                    color: primaryColor,
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
                    locale.addresstitle,
                    style: TextStyle(
                      color: scaffoldBgColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: ListView.builder(
                    itemCount: list_of_address.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16),
                        child: Container(
                          height: 25.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: primaryColor, width: 3),
                              color: scaffoldLightColor),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      Text(
                                        locale.Address,
                                        style: primaryColor18BoldTextStyle,
                                      ),
                                      Text(
                                        list_of_address[index].landMark,
                                        style: primaryColor18BoldTextStyle,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        locale.PINCODE,
                                        style: primaryColor18BoldTextStyle,
                                      ),
                                      Text(
                                        list_of_address[index].pin.toString(),
                                        style: primaryColor18BoldTextStyle,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "ADDRESS TYPE :",
                                        style: primaryColor18BoldTextStyle,
                                      ),
                                      Text(
                                        list_of_address[index].addressType,
                                        style: primaryColor18BoldTextStyle,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return SafeArea(
                  child: Scaffold(
                      backgroundColor: scaffoldBgColor,
                      body: Text(" Oops !! No data ")));
            }
          }
        });
  }
}
