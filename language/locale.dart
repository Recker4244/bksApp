import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'languages/hindi.dart';
import 'languages/english.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'hi': hindi(),
  };

  String get signin {
    return _localizedValues[locale.languageCode]['signin'];
  }

  String get PhoneNumber {
    return _localizedValues[locale.languageCode]['PhoneNumber'];
  }

  String get uncheck {
    return _localizedValues[locale.languageCode]['uncheck'];
  }

  String get continuebutton {
    return _localizedValues[locale.languageCode]['continue'];
  }

  String get willSend {
    return _localizedValues[locale.languageCode]['willSend'];
  }

  String get guestLogin {
    return _localizedValues[locale.languageCode]['guestLogin'];
  }

  String get Choose {
    return _localizedValues[locale.languageCode]['Choose'];
  }

  String get Hindi {
    return _localizedValues[locale.languageCode]['Hindi'];
  }

  String get English {
    return _localizedValues[locale.languageCode]['English'];
  }

  String get enterOTP {
    return _localizedValues[locale.languageCode]['enterOTP'];
  }

  String get resend {
    return _localizedValues[locale.languageCode]['resend'];
  }

  String get welcome {
    return _localizedValues[locale.languageCode]['welcome'];
  }

  String get PortoflioBalance {
    return _localizedValues[locale.languageCode]['PortoflioBalance'];
  }

  String get TotalBalance {
    return _localizedValues[locale.languageCode]['TotalBalance'];
  }

  String get GRAM {
    return _localizedValues[locale.languageCode]['GRAM'];
  }

  String get BuyRate {
    return _localizedValues[locale.languageCode]['BuyRate'];
  }

  String get SellRate {
    return _localizedValues[locale.languageCode]['SellRate'];
  }

  String get BuyInstantGold {
    return _localizedValues[locale.languageCode]['BuyInstantGold'];
  }

  String get SellInstantGold {
    return _localizedValues[locale.languageCode]['SellInstantGold'];
  }

  String get BuySave {
    return _localizedValues[locale.languageCode]['BuySave'];
  }

  String get BUY {
    return _localizedValues[locale.languageCode]['BUY'];
  }

  String get SAVE {
    return _localizedValues[locale.languageCode]['SAVE'];
  }

  String get create {
    return _localizedValues[locale.languageCode]['create'];
  }

  String get ByWeight {
    return _localizedValues[locale.languageCode]['ByWeight'];
  }

  String get ByValue {
    return _localizedValues[locale.languageCode]['ByValue'];
  }

  String get yourcode {
    return _localizedValues[locale.languageCode]['yourcode'];
  }

  String get refer {
    return _localizedValues[locale.languageCode]['refer'];
  }

  String get perGrame {
    return _localizedValues[locale.languageCode]['perGrame'];
  }

  String get Sellyour {
    return _localizedValues[locale.languageCode]['Sellyour'];
  }

  String get yourPortfolio {
    return _localizedValues[locale.languageCode]['yourPortfolio'];
  }

  String get totalSaved {
    return _localizedValues[locale.languageCode]['totalSaved'];
  }

  String get currentValue {
    return _localizedValues[locale.languageCode]['currentValue'];
  }

  String get TotalinPlans {
    return _localizedValues[locale.languageCode]['TotalinPlans'];
  }

  String get TotalInstant {
    return _localizedValues[locale.languageCode]['TotalInstant'];
  }

  String get TotalReferal {
    return _localizedValues[locale.languageCode]['TotalReferal'];
  }

  String get TotalPlanBonus {
    return _localizedValues[locale.languageCode]['TotalPlanBonus'];
  }

  String get CheckDetails {
    return _localizedValues[locale.languageCode]['CheckDetails'];
  }

  String get KYCVerified {
    return _localizedValues[locale.languageCode]['KYCVerified'];
  }

  String get editProfile {
    return _localizedValues[locale.languageCode]['editProfile'];
  }

  String get edityourProfile {
    return _localizedValues[locale.languageCode]['edityourProfile'];
  }

  String get BankDetails {
    return _localizedValues[locale.languageCode]['BankDetails'];
  }

  String get HereBank {
    return _localizedValues[locale.languageCode]['HereBank'];
  }

  String get AddressDetails {
    return _localizedValues[locale.languageCode]['AddressDetails'];
  }

  String get hereAddress {
    return _localizedValues[locale.languageCode]['hereAddress'];
  }

  String get Portfolio {
    return _localizedValues[locale.languageCode]['Portfolio'];
  }

  String get herePortfolio {
    return _localizedValues[locale.languageCode]['herePortfolio'];
  }

  String get Transactions {
    return _localizedValues[locale.languageCode]['Transactions'];
  }

  String get HereTransaction {
    return _localizedValues[locale.languageCode]['HereTransaction'];
  }

  String get Orders {
    return _localizedValues[locale.languageCode]['Orders'];
  }

  String get hereOrders {
    return _localizedValues[locale.languageCode]['hereOrders'];
  }

  String get collections {
    return _localizedValues[locale.languageCode]['collections'];
  }

  String get hereCollections {
    return _localizedValues[locale.languageCode]['hereCollections'];
  }

  String get Appointments {
    return _localizedValues[locale.languageCode]['Appointments'];
  }

  String get hereAppointments {
    return _localizedValues[locale.languageCode]['hereAppointments'];
  }

  String get enterMobileNumber {
    return _localizedValues[locale.languageCode]['enterMobileNumber'];
  }

  String get Terms {
    return _localizedValues[locale.languageCode]['Terms'];
  }

  String get hereTerms {
    return _localizedValues[locale.languageCode]['hereTerms'];
  }

  String get Privacy {
    return _localizedValues[locale.languageCode]['Privacy'];
  }

  String get herePrivacy {
    return _localizedValues[locale.languageCode]['herePrivacy'];
  }

  String get returnPolicy {
    return _localizedValues[locale.languageCode]['returnPolicy'];
  }

  String get hereReturn {
    return _localizedValues[locale.languageCode]['hereReturn'];
  }

  String get Helpsupport {
    return _localizedValues[locale.languageCode]['Helpsupport'];
  }

  String get hereHelp {
    return _localizedValues[locale.languageCode]['hereHelp'];
  }

  String get RateUs {
    return _localizedValues[locale.languageCode]['RateUs'];
  }

  String get hereRate {
    return _localizedValues[locale.languageCode]['hereRate'];
  }

  String get logout {
    return _localizedValues[locale.languageCode]['logout'];
  }

  String get currentbuy {
    return _localizedValues[locale.languageCode]['currentbuy'];
  }

  String get currentsell {
    return _localizedValues[locale.languageCode]['currentsell'];
  }

  String get yourInstant {
    return _localizedValues[locale.languageCode]['yourInstant'];
  }

  String get GoldSaved {
    return _localizedValues[locale.languageCode]['GoldSaved'];
  }

  String get CurrentValue {
    return _localizedValues[locale.languageCode]['CurrentValue'];
  }

  String get AvgBuyPrice {
    return _localizedValues[locale.languageCode]['AvgBuyPrice'];
  }

  String get AvgSellPrice {
    return _localizedValues[locale.languageCode]['AvgSellPrice'];
  }

  String get Gain {
    return _localizedValues[locale.languageCode]['Gain'];
  }

  String get Loss {
    return _localizedValues[locale.languageCode]['Loss'];
  }

  String get BuyWeight {
    return _localizedValues[locale.languageCode]['BuyWeight'];
  }

  String get BuyValue {
    return _localizedValues[locale.languageCode]['BuyValue'];
  }

  String get SellWeight {
    return _localizedValues[locale.languageCode]['SellWeight'];
  }

  String get SellValue {
    return _localizedValues[locale.languageCode]['SellValue'];
  }

  String get Buy24KT {
    return _localizedValues[locale.languageCode]['Buy24KT'];
  }

  String get Sell24KT {
    return _localizedValues[locale.languageCode]['Sell24KT'];
  }

  String get Buy24KTWeight {
    return _localizedValues[locale.languageCode]['Buy24KTWeight'];
  }

  String get Sell24KTWeight {
    return _localizedValues[locale.languageCode]['Sell24KTWeight'];
  }

  String get Buy24KTValue {
    return _localizedValues[locale.languageCode]['Buy24KTValue'];
  }

  String get Sell24KTValue {
    return _localizedValues[locale.languageCode]['Sell24KTValue'];
  }

  String get weight {
    return _localizedValues[locale.languageCode]['weight'];
  }

  String get value {
    return _localizedValues[locale.languageCode]['value'];
  }

  String get Buy {
    return _localizedValues[locale.languageCode]['Buy'];
  }

  String get Sell {
    return _localizedValues[locale.languageCode]['Sell'];
  }

  String get priceChange {
    return _localizedValues[locale.languageCode]['priceChange'];
  }

  String get cyclePeriod {
    return _localizedValues[locale.languageCode]['cyclePeriod'];
  }

  String get duration {
    return _localizedValues[locale.languageCode]['duration'];
  }

  String get amount {
    return _localizedValues[locale.languageCode]['amount'];
  }

  String get Proceed {
    return _localizedValues[locale.languageCode]['Proceed'];
  }

  String get Saving {
    return _localizedValues[locale.languageCode]['Saving'];
  }

  String get Bonus {
    return _localizedValues[locale.languageCode]['Bonus'];
  }

  String get totalSaving {
    return _localizedValues[locale.languageCode]['totalSaving'];
  }

  String get choosePayment {
    return _localizedValues[locale.languageCode]['choosePayment'];
  }

  String get usePayment {
    return _localizedValues[locale.languageCode]['usePayment'];
  }

  String get herepayment {
    return _localizedValues[locale.languageCode]['herepayment'];
  }

  String get useCOC {
    return _localizedValues[locale.languageCode]['useCOC'];
  }

  String get hereCOC {
    return _localizedValues[locale.languageCode]['hereCOC'];
  }

  String get selectKarat {
    return _localizedValues[locale.languageCode]['selectKarat'];
  }

  String get calculation {
    return _localizedValues[locale.languageCode]['calculation'];
  }

  String get selected {
    return _localizedValues[locale.languageCode]['selected'];
  }

  String get sellper {
    return _localizedValues[locale.languageCode]['sellper'];
  }

  String get weightEntered {
    return _localizedValues[locale.languageCode]['weightEntered'];
  }

  String get approx {
    return _localizedValues[locale.languageCode]['approx'];
  }

  String get PlaceRequest {
    return _localizedValues[locale.languageCode]['PlaceRequest'];
  }

  String get referalBonus {
    return _localizedValues[locale.languageCode]['referalBonus'];
  }

  String get Approximate {
    return _localizedValues[locale.languageCode]['Approximate'];
  }

  String get TotalJoining {
    return _localizedValues[locale.languageCode]['TotalJoining'];
  }

  String get TotalReferral {
    return _localizedValues[locale.languageCode]['TotalReferral'];
  }

  String get joined {
    return _localizedValues[locale.languageCode]['joined'];
  }

  String get click {
    return _localizedValues[locale.languageCode]['click'];
  }

  String get Mature {
    return _localizedValues[locale.languageCode]['Mature'];
  }

  String get planBonus {
    return _localizedValues[locale.languageCode]['planBonus'];
  }

  String get totalWight {
    return _localizedValues[locale.languageCode]['totalWight'];
  }

  String get totalValue {
    return _localizedValues[locale.languageCode]['totalValue'];
  }

  String get total {
    return _localizedValues[locale.languageCode]['total'];
  }

  String get BUYGOLD {
    return _localizedValues[locale.languageCode]['BUYGOLD'];
  }

  String get SKIPPAYMENT {
    return _localizedValues[locale.languageCode]['SKIPPAYMENT'];
  }

  String get banktitle {
    return _localizedValues[locale.languageCode]['banktitle'];
  }

  String get AcctNum {
    return _localizedValues[locale.languageCode]['AcctNum'];
  }

  String get ifsc {
    return _localizedValues[locale.languageCode]['ifsc'];
  }

  String get addresstitle {
    return _localizedValues[locale.languageCode]['addresstitle'];
  }

  String get Address {
    return _localizedValues[locale.languageCode]['Address'];
  }

  String get PINCODE {
    return _localizedValues[locale.languageCode]['PINCODE'];
  }

  String get Description {
    return _localizedValues[locale.languageCode]['Description'];
  }

  String get SKU {
    return _localizedValues[locale.languageCode]['SKU'];
  }

  String get charges {
    return _localizedValues[locale.languageCode]['charges'];
  }

  String get addtocart {
    return _localizedValues[locale.languageCode]['addtocart'];
  }

  String get buyNow {
    return _localizedValues[locale.languageCode]['buyNow'];
  }

  String get cart {
    return _localizedValues[locale.languageCode]['cart'];
  }

  String get Summary {
    return _localizedValues[locale.languageCode]['Summary'];
  }

  String get subTotal {
    return _localizedValues[locale.languageCode]['subTotal'];
  }

  String get delivery {
    return _localizedValues[locale.languageCode]['delivery'];
  }

  String get redeem {
    return _localizedValues[locale.languageCode]['redeem'];
  }

  String get availableinstant {
    return _localizedValues[locale.languageCode]['availableinstant'];
  }

  String get apply {
    return _localizedValues[locale.languageCode]['apply'];
  }

  String get pay {
    return _localizedValues[locale.languageCode]['pay'];
  }

  String get AvailableBalance {
    return _localizedValues[locale.languageCode]['AvailableBalance'];
  }

  String get TotalSaved {
    return _localizedValues[locale.languageCode]['TotalSaved'];
  }

  String get BonusEarned {
    return _localizedValues[locale.languageCode]['BonusEarned'];
  }

  String get SELLREDEEM {
    return _localizedValues[locale.languageCode]['SELLREDEEM'];
  }

  String get home {
    return _localizedValues[locale.languageCode]['home'];
  }

  String get portoflio {
    return _localizedValues[locale.languageCode]['portoflio'];
  }

  String get shop {
    return _localizedValues[locale.languageCode]['shop'];
  }

  String get menu {
    return _localizedValues[locale.languageCode]['menu'];
  }

  String get sell {
    return _localizedValues[locale.languageCode]['sell'];
  }

  String get part {
    return _localizedValues[locale.languageCode]['part'];
  }

  String get oops {
    return _localizedValues[locale.languageCode]['oops'];
  }

  String get yourorder {
    return _localizedValues[locale.languageCode]['yourorder'];
  }

  String get pricetag {
    return _localizedValues[locale.languageCode]['pricetag'];
  }

  String get tryagain {
    return _localizedValues[locale.languageCode]['tryagain'];
  }

  String get Okay {
    return _localizedValues[locale.languageCode]['Okay'];
  }

  String get Congratulations {
    return _localizedValues[locale.languageCode]['Congratulations'];
  }

  String get successmsg {
    return _localizedValues[locale.languageCode]['successmsg'];
  }

  String get taptocopy {
    return _localizedValues[locale.languageCode]['taptocopy'];
  }

  String get showcode {
    return _localizedValues[locale.languageCode]['showcode'];
  }

  String get bankdebit {
    return _localizedValues[locale.languageCode]['bankdebit'];
  }

  String get onHold {
    return _localizedValues[locale.languageCode]['onHold'];
  }

  String get payBefore {
    return _localizedValues[locale.languageCode]['payBefore'];
  }

  String get bonusloss {
    return _localizedValues[locale.languageCode]['bonusloss'];
  }

  String get handling {
    return _localizedValues[locale.languageCode]['handling'];
  }

  String get still {
    return _localizedValues[locale.languageCode]['still'];
  }

  String get proceedTOSELLREDEEM {
    return _localizedValues[locale.languageCode]['proceedTOSELLREDEEM'];
  }

  String get ordernotplaced {
    return _localizedValues[locale.languageCode]['ordernotplaced'];
  }

  String get failuremsg {
    return _localizedValues[locale.languageCode]['failuremsg'];
  }

  String get forfietwarning {
    return _localizedValues[locale.languageCode]['forfietwarning'];
  }

  String get skip {
    return _localizedValues[locale.languageCode]['skip'];
  }

  String get unpaidskip {
    return _localizedValues[locale.languageCode]['unpaidskip'];
  }

  String get canceled {
    return _localizedValues[locale.languageCode]['canceled'];
  }

  String get orderDetails {
    return _localizedValues[locale.languageCode]['orderDetails'];
  }

  String get OrderID {
    return _localizedValues[locale.languageCode]['OrderID'];
  }

  String get OrderPlacedOn {
    return _localizedValues[locale.languageCode]['OrderPlacedOn'];
  }

  String get Status {
    return _localizedValues[locale.languageCode]['Status'];
  }

  String get cn {
    return _localizedValues[locale.languageCode]['cn'];
  }

  String get db {
    return _localizedValues[locale.languageCode]['db'];
  }

  String get VerificationOTP {
    return _localizedValues[locale.languageCode]['VerificationOTP'];
  }

  String get MOP {
    return _localizedValues[locale.languageCode]['MOP'];
  }

  String get SavingsApplied {
    return _localizedValues[locale.languageCode]['SavingsApplied'];
  }

  String get redeemGold {
    return _localizedValues[locale.languageCode]['redeemGold'];
  }

  String get InstantGold {
    return _localizedValues[locale.languageCode]['InstantGold'];
  }

  String get Taxes {
    return _localizedValues[locale.languageCode]['Taxes'];
  }

  String get yourTransactions {
    return _localizedValues[locale.languageCode]['yourTransactions'];
  }

  String get Credits {
    return _localizedValues[locale.languageCode]['Credits'];
  }

  String get Debits {
    return _localizedValues[locale.languageCode]['Debits'];
  }

  String get appoinmentDetails {
    return _localizedValues[locale.languageCode]['appoinmentDetails'];
  }

  String get reqeustPlacedOn {
    return _localizedValues[locale.languageCode]['reqeustPlacedOn'];
  }

  String get verificationDate {
    return _localizedValues[locale.languageCode]['verificationDate'];
  }

  String get verifier {
    return _localizedValues[locale.languageCode]['verifier'];
  }

  String get Valuation {
    return _localizedValues[locale.languageCode]['Valuation'];
  }

  String get StoreLocation {
    return _localizedValues[locale.languageCode]['StoreLocation'];
  }

  String get directions {
    return _localizedValues[locale.languageCode]['directions'];
  }

  String get collectionDetails {
    return _localizedValues[locale.languageCode]['collectionDetails'];
  }

  String get planEnrolledon {
    return _localizedValues[locale.languageCode]['planEnrolledon'];
  }

  String get collectorPhoneNumber {
    return _localizedValues[locale.languageCode]['collectorPhoneNumber'];
  }

  String get Collector {
    return _localizedValues[locale.languageCode]['Collector'];
  }

  String get ToCollect {
    return _localizedValues[locale.languageCode]['ToCollect'];
  }

  String get landmark {
    return _localizedValues[locale.languageCode]['landmark'];
  }

  String get Pincode {
    return _localizedValues[locale.languageCode]['Pincode'];
  }

  String get tomygold {
    return _localizedValues[locale.languageCode]['tomygold'];
  }

  String get youcando {
    return _localizedValues[locale.languageCode]['youcando'];
  }

  String get buygoldbenefits {
    return _localizedValues[locale.languageCode]['buygoldbenefits'];
  }

  String get instantbenefits {
    return _localizedValues[locale.languageCode]['instantbenefits'];
  }

  String get referingBenefits {
    return _localizedValues[locale.languageCode]['referingBenefits'];
  }

  String get SaveBonus {
    return _localizedValues[locale.languageCode]['SaveBonus'];
  }

  String get SaveBonusenefit {
    return _localizedValues[locale.languageCode]['SaveBonusenefit'];
  }

  String get sellgoldtitle {
    return _localizedValues[locale.languageCode]['sellgoldtitle'];
  }

  String get sellBenfits {
    return _localizedValues[locale.languageCode]['sellBenfits'];
  }

  String get howTo {
    return _localizedValues[locale.languageCode]['howTo'];
  }

  String get testimonials {
    return _localizedValues[locale.languageCode]['testimonials'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
