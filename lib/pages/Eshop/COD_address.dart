import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gold247/language/locale.dart';

enum adressType { Home, Work, Others }
adressType _character = adressType.Home;

class Adress_Details_Payment extends StatefulWidget {
  const Adress_Details_Payment({Key key}) : super(key: key);

  @override
  _Adress_Details_PaymentState createState() => _Adress_Details_PaymentState();
}

class _Adress_Details_PaymentState extends State<Adress_Details_Payment> {
  final addresscontroller = TextEditingController();
  final PINcontroller = TextEditingController();
  final Landmarkcontroller = TextEditingController();

  bool available = true;
  Future addAddres() async {
    if (_character.toString() == "Others") {
      _character = adressType.Home;
    }
    http.Response response = await http.put(
      Uri.parse("${baseurl}/api/account/"),
      body: json.encode({
        'user': Userdata.id,
        'landMark': addresscontroller.text,
        'isDefaultAddress': true,
        'pin': PINcontroller.text,
        'addressType': _character.toString()
      }),
    );
    if (response.statusCode == 200) {
      print(await response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  checkPincode(String pincode) async {
    var request = http.Request(
        'GET', Uri.parse('${baseurl}/api/pincode/search/${pincode}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      final status = det['msg'];
      if (status == "success") {
        setState(() {
          available = true;
        });
      } else {
        setState(() {
          available = false;
        });
      }
    } else {
      setState(() {
        available = false;
      });
    }
  }

  @override
  final _formkeycod = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          'BUY GOLD',
          style: TextStyle(
            color: scaffoldBgColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkeycod,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height20Space,
              height20Space,
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
                    child: TextFormField(
                      controller: addresscontroller,
                      validator: (value) =>
                          value.isEmpty ? "Field cannot be empty" : null,
                      keyboardType: TextInputType.streetAddress,
                      style: primaryColor16MediumTextStyle,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
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
                    child: TextFormField(
                      controller: PINcontroller,
                      validator: (value) =>
                          value.isEmpty ? "Field cannot be empty" : null,
                      keyboardType: TextInputType.number,
                      style: primaryColor16MediumTextStyle,
                      decoration: InputDecoration(
                        labelText: 'PinCode',
                        labelStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                      ),
                      onChanged: (value) {
                        checkPincode(value);
                      },
                    ),
                  ),
                ),
              ),
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
                    child: TextFormField(
                      controller: Landmarkcontroller,
                      validator: (value) =>
                          value.isEmpty ? "Field cannot be empty" : null,
                      keyboardType: TextInputType.streetAddress,
                      style: primaryColor16MediumTextStyle,
                      decoration: InputDecoration(
                        labelText: 'LandMark',
                        labelStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: primaryColor, width: 1),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
              heightSpace,
              !available
                  ? Text(
                      'Not Serviceable Area, Please Change your Address',
                      style: black14SemiBoldTextStyle,
                    )
                  : Container(),
              height20Space,
              height20Space,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Adress_Type(),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: fixPadding * 6),
              //   child:
              // ),
              SizedBox(height: fixPadding * 3.0),
              Proceed_Button(),
            ],
          ),
        ),
      ),
    );
  }
}

class Adress_Type extends StatefulWidget {
  @override
  _Adress_TypeState createState() => _Adress_TypeState();
}

class _Adress_TypeState extends State<Adress_Type> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Adress Type',
          style: primaryColor16MediumTextStyle,
        ),
        height5Space,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Adress_Type_selector(),
          ],
        ),
      ],
    );
  }
}

class Adress_Type_selector extends StatefulWidget {
  //Adress_Type_selector(this.type);

  @override
  _Adress_Type_selectorState createState() => _Adress_Type_selectorState();
}

class _Adress_Type_selectorState extends State<Adress_Type_selector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Home,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          "Home",
          style: primaryColor16MediumTextStyle,
        ),
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Work,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          "Work",
          style: primaryColor16MediumTextStyle,
        ),
        Radio<adressType>(
          activeColor: primaryColor,
          value: adressType.Others,
          groupValue: _character,
          onChanged: (adressType value) {
            setState(() {
              _character = value;
            });
          },
        ),
        widthSpace,
        Text(
          "Others",
          style: primaryColor16MediumTextStyle,
        ),
      ],
    );
  }
}

class Proceed_Button extends StatelessWidget {
  const Proceed_Button({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context){return BuySuccessScreen();}));
        },
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Proceed'.toUpperCase(),
                style: TextStyle(
                  color: scaffoldBgColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
