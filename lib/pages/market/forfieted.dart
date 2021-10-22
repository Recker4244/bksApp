import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/language/locale.dart';

class Forfeited extends StatefulWidget {
  final List<subscription> forfeited;
  const Forfeited({Key key, this.forfeited}) : super(key: key);

  @override
  _ForfeitedState createState() => _ForfeitedState();
}

class _ForfeitedState extends State<Forfeited> {
  double compute(subscription cal) {
    double amount = 0;
    for (int i = 0; i < cal.installments.length; i++) {
      if (cal.installments[i].status == "Saved" ||
          cal.installments[i].status == "Released") {
        amount += double.parse(cal.installments[i].gold.toString());
      } else
        amount -= double.parse(cal.installments[i].gold.toString());
    }
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return (widget.forfeited == null)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightSpace,
              heightSpace,
              Center(
                child: Text(
                  'No Plans',
                  style: grey20BoldTextStyle,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: widget.forfeited.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              double gold = compute(widget.forfeited[index]);
              final item = widget.forfeited[index];
              return Padding(
                padding: (index != widget.forfeited.length - 1)
                    ? EdgeInsets.fromLTRB(fixPadding * 1.5, fixPadding * 1.5,
                        fixPadding * 1.5, 0.0)
                    : EdgeInsets.all(fixPadding * 1.5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.center,
                            child: TotalBalance(
                              sub: widget.forfeited[index],
                              avail: gold.toStringAsFixed(2),
                            )));
                  },
                  child: Container(
                    height: 138,
                    width: 90,
                    decoration: BoxDecoration(
                      color: scaffoldBgColor,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                widthSpace,
                                Image.asset(
                                  "assets/crypto_icon/gold_ingots.png",
                                  height: 44,
                                  width: 44,
                                  fit: BoxFit.cover,
                                ),
                                widthSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Gold Saved in this Plan",
                                      style: grey14BoldTextStyle,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${gold.toStringAsFixed(2)} GRAM",
                                      style: black16BoldTextStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: primaryColor,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'SELL/REDEEM',
                                style: black14BoldTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
