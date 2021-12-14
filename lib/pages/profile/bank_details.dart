import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gold247/models/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gold247/models/bankDetails.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/pages/screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold247/language/locale.dart';

class BankDetails extends StatefulWidget {
  final String buysellId;
  final String gold;
  final String subscriptionId;
  const BankDetails({Key key, this.buysellId, this.gold, this.subscriptionId})
      : super(key: key);

  @override
  _BankDetailsState createState() => _BankDetailsState();
}

String stringResponse;
Map mapResponse;

class _BankDetailsState extends State<BankDetails> {
  bool value;
  String selectedAccountType = 'Savings';
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  FocusNode accountFocus = FocusNode();
  FocusNode ifscFocus = FocusNode();

// Future<bool> verifyBanckAccount(String ifsc,String accntno)async{
//    final String apiUrl =
//         "https://api.sandbox.co.in/bank/${ifsc}/accounts/${accntno}/verify?name=${Userdata.fname} DOE&mobile=${Userdata.mobile}";
//     var url = Uri.parse(apiUrl);
//     var headers = {
//   'Authorization': 'eyJhbGciOiJIUzUxMiJ9.eyJhdWQiOiJBUEkiLCJyZWZyZXNoX3Rva2VuIjoiZXlKaGJHY2lPaUpJVXpVeE1pSjkuZXlKaGRXUWlPaUpCVUVraUxDSnpkV0lpT2lKclpYbGZiR2wyWlY5QlpHVXFLaW9xS2lvcUtpb3FLaW9xS2lvcUtpb3FLaW9xS2lvcUtsVjRjeUlzSW1Gd2FWOXJaWGtpT2lKclpYbGZiR2wyWlY5QlpHVXFLaW9xS2lvcUtpb3FLaW9xS2lvcUtpb3FLaW9xS2lvcUtsVjRjeUlzSW1semN5STZJbUZ3YVM1eGRXbGphMjh1WTI5dElpd2laWGh3SWpveE5Ua3dPVFk1TmpBd0xDSnBiblJsYm5RaU9pSlNSVVpTUlZOSVgxUlBTMFZPSWl3aWFXRjBJam94TlRVNU16UTNNakF3ZlEueHNmYkhQTERFRlRvTy1OUWdaUUpLM25OUjFxdlhvWmhaOHRqS3gzSExydjZiVkJaMHpJZEZ5ai1MUTg1YnJZS0xXQnFnZHlzZ1NDSXlDUXNtV2VOYkEiLCJzdWIiOiJqb2huQGRvZS5jb20iLCJhcGlfa2V5Ijoia2V5X2xpdmVfQWRlKioqKioqKioqKioqKioqKioqKioqKioqKipVeHMiLCJpc3MiOiJhcGkucXVpY2tvLmNvbSIsImV4cCI6MTU5MTA1NjAwMCwiaW50ZW50IjoiQUNDRVNTX1RPS0VOIiwiaWF0IjoxNTkwOTY5NjAwfQ.nH23CR5RHGQ0U19I_vq3vyJ_85A1a2iEMQij5QHgJQdDuS9x7FmTidsr1CQabSFF5ujE40SFxHv1gJM20TauUw',
//   'x-api-key': 'key_live_Ade**************************Uxs',
//   'x-api-version': '3.1'
// };
// final response = await http.post(url, headers: headers);
// if(response.statusCode==200){}
// }
  Future getBankDetails() async {
    http.Response response = await http.get(
      Uri.parse("${baseurl}/api/bank/${Userdata.id}"),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      if (responseString['data'] != null) {
        setState(() {
          accountNumberController.text = responseString['data']['Accountnum'];
          ifscCodeController.text = responseString['data']['IFSC'];
          value = false;
        });
      } else {
        setState(() {
          value = true;
        });
      }
    }
  }

  Future sell() async {
    var headers = {'Content-Type': 'application/json'};
    final body = {"buySellId": widget.buysellId, "goldsell": widget.gold};
    var request = http.Request(
        'POST',
        Uri.parse(
            '${baseurl}/api/sell-subscription/${widget.subscriptionId}/${Userdata.id}'));
    request.body = jsonEncode(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<String> getAccessToken() async {
    var headers = {
      'x-api-key': 'key_live_1XilWqECfePBMRzHKIfj4719kkc7q7C4',
      'x-api-secret': 'secret_live_x9NUTRidCJAidEDRj4JT9VyMwgcttZ2x',
      'x-api-version': '1.0'
    };
    var request = http.Request(
        'POST', Uri.parse('https://api.sandbox.co.in/authenticate'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      return det['access_token'];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future apiCall(String ifsc, String accntno) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRing(
                      color: primaryColor,
                      size: 40.0,
                      lineWidth: 1.2,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Verifying Bank..',
                      style: grey14MediumTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    if (accountNumberController.text == "") {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'Account Number Not Specified.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return FocusScope.of(context).requestFocus(accountFocus);
    }
    if (ifscCodeController.text == "") {
      Navigator.pop(context, true);
      Fluttertoast.showToast(
        msg: 'IFSC Code Not Specified.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return FocusScope.of(context).requestFocus(ifscFocus);
    }
    String token = await getAccessToken();
    http.Response response;
    var headers = {
      'Authorization': token,
      'x-api-key': 'key_live_1XilWqECfePBMRzHKIfj4719kkc7q7C4',
      'x-api-version': '1.0'
    };
    final queryParams = {
      'name': Userdata.fname,
      'mobile': Userdata.mobile.toString()
    };

    final uri = Uri.https('api.sandbox.co.in',
        'bank/${ifsc}/accounts/${accntno}/verify', queryParams);
    response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final responseString = jsonDecode(response.body);

      if (value == true) {
        http.Response responseBank = await http.post(
          Uri.parse("${baseurl}/api/bank/${Userdata.id}"),
          body: {
            "Accountnum": accountNumberController.text,
            "IFSC": ifscCodeController.text,
          },
        );
        final responseString = json.decode(responseBank.body);
        Map datas = responseString['data']['bank'];
        setState(() {
          bankdetail = bankDetails.fromJson(datas);
        });
        Navigator.pop(context, true);

        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  backgroundColor: scaffoldBgColor,
                  title: Center(
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        size: 30.0,
                        color: scaffoldBgColor,
                      ),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Center(
                            child: Text(
                          "${widget.gold} GRAM SOLD",
                          style: black16BoldTextStyle,
                        )),
                        Center(
                            child: Text(
                          '${DateTime.now()}',
                          style: black14MediumTextStyle,
                        )),
                        heightSpace,
                        Center(
                            child: Text(
                          'Money will be credited to your bank account ending with ${accountNumberController.text.substring(accountNumberController.text.length - 4)} within 72 Hours',
                          style: black14MediumTextStyle,
                        )),
                      ],
                    ),
                  ),
                ));
      } else if (value == false) {
        http.Response responseBank = await http.put(
          Uri.parse("${baseurl}/api/bank/update/${Userdata.id}"),
          body: {
            "Accountnum": accountNumberController.text,
            "IFSC": ifscCodeController.text,
          },
        );
        final responseString = json.decode(responseBank.body);
        Map datas = responseString['data'];
        // setState(() {
        //   bankdetail = bankDetails.fromJson(datas);
        // });
        Navigator.pop(context, true);
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => BottomBar(
              index: 1,
            ),
          ),
        );
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  backgroundColor: scaffoldBgColor,
                  title: Center(
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        size: 30.0,
                        color: scaffoldBgColor,
                      ),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Center(
                            child: Text(
                          "${widget.gold} GRAM SOLD",
                          style: black16BoldTextStyle,
                        )),
                        Center(
                            child: Text(
                          '${DateTime.now()}',
                          style: black14MediumTextStyle,
                        )),
                        heightSpace,
                        Center(
                            child: Text(
                          'Money will be credited to your bank account ending with ${accountNumberController.text.substring(accountNumberController.text.length - 4)} within 72 Hours',
                          style: black14MediumTextStyle,
                        )),
                      ],
                    ),
                  ),
                ));

        // return Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade,
        //     child: BankSuccessScreen(),
        //   ),
        // );
      }
    } else if (response.statusCode == 404) {
      Navigator.pop(context, true);
      return Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: BankFailScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    getBankDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    // selectAccountTypeItem(type) {
    //   double width = MediaQuery.of(context).size.width;
    //   return Expanded(
    //     child: InkWell(
    //       onTap: () {
    //         setState(() {
    //           selectedAccountType = type;
    //         });
    //       },
    //       child: Container(
    //         width: (width - fixPadding * 4.0) / 2,
    //         child: Row(
    //           // mainAxisAlignment: MainAxisAlignment.start,
    //           // crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Container(
    //               width: 18.0,
    //               height: 18.0,
    //               alignment: Alignment.center,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(9.0),
    //                 border: Border.all(
    //                   width: 0.8,
    //                   color: (selectedAccountType == type)
    //                       ? primaryColor
    //                       : greenColor,
    //                 ),
    //               ),
    //               child: Container(
    //                 width: 10.0,
    //                 height: 10.0,
    //                 alignment: Alignment.center,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(5.0),
    //                   color: (selectedAccountType == type)
    //                       ? primaryColor
    //                       : whiteColor,
    //                 ),
    //               ),
    //             ),
    //             widthSpace,
    //             Text(
    //               type,
    //               style: primaryColor16BoldTextStyle,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }

    bankDetail() {
      return Padding(
        padding: const EdgeInsets.all(fixPadding * 3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field Start

            Container(
              padding: EdgeInsets.only(bottom: fixPadding * 2.0),
              child: Theme(
                data: ThemeData(
                  primaryColor: whiteColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextFormField(
                  focusNode: accountFocus,
                  controller: accountNumberController,
                  keyboardType: TextInputType.number,
                  style: primaryColor16BoldTextStyle,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    fillColor: whiteColor,
                    labelText: locale.AcctNum,
                    labelStyle: primaryColor18BoldTextStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 0.7),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            // Name Field End

            // IFSC Code Field Start
            Container(
              padding: EdgeInsets.only(bottom: fixPadding * 2.0),
              child: Theme(
                data: ThemeData(
                  primaryColor: whiteColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextFormField(
                  focusNode: ifscFocus,
                  controller: ifscCodeController,
                  keyboardType: TextInputType.text,
                  style: primaryColor16BoldTextStyle,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    fillColor: whiteColor,
                    labelText: locale.ifsc,
                    labelStyle: primaryColor18BoldTextStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 0.7),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            // IFSC Code Field End

            // Select Account Type Start
            // Text(
            //   'Select Account Type',
            //   style: primaryColor16BoldTextStyle,
            // ),
            heightSpace,

            // Row(
            //   // mainAxisAlignment: MainAxisAlignment.start,
            //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   // crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     selectAccountTypeItem('Savings'),
            //     selectAccountTypeItem('Current'),
            //   ],
            // ),

            // Select Account Type End

            height20Space,

            // Save Button Start
            InkWell(
              onTap: () => apiCall(
                  ifscCodeController.text, accountNumberController.text),
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(fixPadding * 1.5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: primaryColor,
                ),
                child: Text(
                  'Proceed',
                  style: white14BoldTextStyle,
                ),
              ),
            ),
            // Save Button End
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          locale.banktitle,
          style: white16SemiBoldTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance,
            color: primaryColor,
            size: 120,
          ),
          bankDetail(),
        ],
      ),
    );
  }

  // info() {
  //   return Container(
  //     padding: EdgeInsets.all(fixPadding * 2.0),
  //     color: greyColor.withOpacity(0.25),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Icon(
  //           Icons.check_circle,
  //           size: 30.0,
  //           color: greenColor,
  //         ),
  //         widthSpace,
  //         Expanded(
  //           child: Text(
  //             'Congratulations! You have successfully added your bank account details.',
  //             style: black14RegularTextStyle,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
