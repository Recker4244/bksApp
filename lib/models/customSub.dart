class customSub {
  String createdAt;
  CustomPlan customPlan;
  String docType;
  String id;
  List<Installments> installments;
  String maturityDate;
  double planBonus;
  int skipCount;
  String status;
  String trackingId;
  int unpaidInvestments;
  int unpaidSkips;
  String updatedAt;
  User user;
  String plan;
  num savedAmount;
  num savedWeight;
  num totalBonus;

  customSub(
      {this.createdAt,
      this.customPlan,
      this.docType,
      this.id,
      this.installments,
      this.maturityDate,
      this.planBonus,
      this.skipCount,
      this.status,
      this.trackingId,
      this.unpaidInvestments,
      this.unpaidSkips,
      this.updatedAt,
      this.user,
      this.plan,
      this.savedAmount,
      this.savedWeight,
      this.totalBonus});

  customSub.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    customPlan = json['customPlan'] != null
        ? new CustomPlan.fromJson(json['customPlan'])
        : null;
    docType = json['docType'];
    id = json['id'];
    if (json['installments'] != null) {
      installments = <Installments>[];
      json['installments'].forEach((v) {
        installments.add(new Installments.fromJson(v));
      });
    }
    maturityDate = json['maturityDate'];
    planBonus = json['planBonus'];
    skipCount = json['skipCount'];
    status = json['status'];
    trackingId = json['trackingId'];
    unpaidInvestments = json['unpaidInvestments'];
    unpaidSkips = json['unpaidSkips'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    plan = json['plan'];
    savedAmount = json['savedAmount'];
    savedWeight = json['savedWeight'];
    totalBonus = json['totalBonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    if (this.customPlan != null) {
      data['customPlan'] = this.customPlan.toJson();
    }
    data['docType'] = this.docType;
    data['id'] = this.id;
    if (this.installments != null) {
      data['installments'] = this.installments.map((v) => v.toJson()).toList();
    }
    data['maturityDate'] = this.maturityDate;
    data['planBonus'] = this.planBonus;
    data['skipCount'] = this.skipCount;
    data['status'] = this.status;
    data['trackingId'] = this.trackingId;
    data['unpaidInvestments'] = this.unpaidInvestments;
    data['unpaidSkips'] = this.unpaidSkips;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['plan'] = this.plan;
    data['savedAmount'] = this.savedAmount;
    data['savedWeight'] = this.savedWeight;
    data['totalBonus'] = this.totalBonus;
    return data;
  }
}

class CustomPlan {
  CyclePeriod cyclePeriod;
  int duration;
  String id;
  String mode;
  String name;
  String planType;

  CustomPlan(
      {this.cyclePeriod,
      this.duration,
      this.id,
      this.mode,
      this.name,
      this.planType});

  CustomPlan.fromJson(Map<String, dynamic> json) {
    cyclePeriod = json['cyclePeriod'] != null
        ? new CyclePeriod.fromJson(json['cyclePeriod'])
        : null;
    duration = json['duration'];
    id = json['id'];
    mode = json['mode'];
    name = json['name'];
    planType = json['planType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cyclePeriod != null) {
      data['cyclePeriod'] = this.cyclePeriod.toJson();
    }
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['mode'] = this.mode;
    data['name'] = this.name;
    data['planType'] = this.planType;
    return data;
  }
}

class CyclePeriod {
  String createdAt;
  int cycle;
  String docType;
  int graceperiod;
  String id;
  num minValue;
  num minWeight;
  String name;
  String shortName;
  String status;
  String updatedAt;

  CyclePeriod(
      {this.createdAt,
      this.cycle,
      this.docType,
      this.graceperiod,
      this.id,
      this.minValue,
      this.minWeight,
      this.name,
      this.shortName,
      this.status,
      this.updatedAt});

  CyclePeriod.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    cycle = json['cycle'];
    docType = json['docType'];
    graceperiod = json['graceperiod'];
    id = json['id'];
    minValue = json['minValue'];
    minWeight = json['minWeight'];
    name = json['name'];
    shortName = json['shortName'];
    status = json['status'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['cycle'] = this.cycle;
    data['docType'] = this.docType;
    data['graceperiod'] = this.graceperiod;
    data['id'] = this.id;
    data['minValue'] = this.minValue;
    data['minWeight'] = this.minWeight;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Installments {
  num amount;
  String collector;
  String createdAt;
  String docType;
  num gold;
  String id;
  String mode;
  String otp;
  String paymentId;
  String status;
  String updatedAt;
  String user;

  Installments(
      {this.amount,
      this.collector,
      this.createdAt,
      this.docType,
      this.gold,
      this.id,
      this.mode,
      this.otp,
      this.paymentId,
      this.status,
      this.updatedAt,
      this.user});

  Installments.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    collector = json['collector'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    gold = json['gold'];
    id = json['id'];
    mode = json['mode'];
    otp = json['otp'];
    paymentId = json['paymentId'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['collector'] = this.collector;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['gold'] = this.gold;
    data['id'] = this.id;
    data['mode'] = this.mode;
    data['otp'] = this.otp;
    data['paymentId'] = this.paymentId;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}

class User {
  List<String> gBPBonusEntries;
  String gBPcode;
  List<Addresses> addresses;
  String createdAt;
  String deviceToken;
  String dob;
  String docType;
  String email;
  String fname;
  String id;
  String image;
  bool isInvested;
  bool isWhatsapp;
  int joiningBonus;
  String level;
  int mobile;
  String pan;
  String refCode;
  String referenceType;
  Null referral;
  List<String> referralBonusEntries;
  String role;
  String updatedAt;

  User(
      {this.gBPBonusEntries,
      this.gBPcode,
      this.addresses,
      this.createdAt,
      this.deviceToken,
      this.dob,
      this.docType,
      this.email,
      this.fname,
      this.id,
      this.image,
      this.isInvested,
      this.isWhatsapp,
      this.joiningBonus,
      this.level,
      this.mobile,
      this.pan,
      this.refCode,
      this.referenceType,
      this.referral,
      this.referralBonusEntries,
      this.role,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    gBPBonusEntries = json['GBPBonusEntries'].cast<String>();
    gBPcode = json['GBPcode'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    deviceToken = json['deviceToken'];
    dob = json['dob'];
    docType = json['docType'];
    email = json['email'];
    fname = json['fname'];
    id = json['id'];
    image = json['image'];
    isInvested = json['isInvested'];
    isWhatsapp = json['isWhatsapp'];
    joiningBonus = json['joiningBonus'];
    level = json['level'];
    mobile = json['mobile'];
    pan = json['pan'];
    refCode = json['refCode'];
    referenceType = json['referenceType'];
    referral = json['referral'];
    referralBonusEntries = json['referralBonusEntries'].cast<String>();
    role = json['role'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GBPBonusEntries'] = this.gBPBonusEntries;
    data['GBPcode'] = this.gBPcode;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['deviceToken'] = this.deviceToken;
    data['dob'] = this.dob;
    data['docType'] = this.docType;
    data['email'] = this.email;
    data['fname'] = this.fname;
    data['id'] = this.id;
    data['image'] = this.image;
    data['isInvested'] = this.isInvested;
    data['isWhatsapp'] = this.isWhatsapp;
    data['joiningBonus'] = this.joiningBonus;
    data['level'] = this.level;
    data['mobile'] = this.mobile;
    data['pan'] = this.pan;
    data['refCode'] = this.refCode;
    data['referenceType'] = this.referenceType;
    data['referral'] = this.referral;
    data['referralBonusEntries'] = this.referralBonusEntries;
    data['role'] = this.role;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Addresses {
  String addressType;
  String createdAt;
  String docType;
  String id;
  bool isDefaultAddress;
  String landMark;
  int pin;
  String updatedAt;
  String user;

  Addresses(
      {this.addressType,
      this.createdAt,
      this.docType,
      this.id,
      this.isDefaultAddress,
      this.landMark,
      this.pin,
      this.updatedAt,
      this.user});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    isDefaultAddress = json['isDefaultAddress'];
    landMark = json['landMark'];
    pin = json['pin'];
    updatedAt = json['updatedAt'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressType'] = this.addressType;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['isDefaultAddress'] = this.isDefaultAddress;
    data['landMark'] = this.landMark;
    data['pin'] = this.pin;
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}
