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
  int savedAmount;
  int savedWeight;
  int totalBonus;

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
      installments = new List<Installments>();
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
    data['savedAmount'] = this.savedAmount;
    data['savedWeight'] = this.savedWeight;
    data['totalBonus'] = this.totalBonus;
    return data;
  }
}

class CustomPlan {
  List<CyclePeriod> cyclePeriod;
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
    if (json['cyclePeriod'] != null) {
      cyclePeriod = new List<CyclePeriod>();
      json['cyclePeriod'].forEach((v) {
        cyclePeriod.add(new CyclePeriod.fromJson(v));
      });
    }
    duration = json['duration'];
    id = json['id'];
    mode = json['mode'];
    name = json['name'];
    planType = json['planType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cyclePeriod != null) {
      data['cyclePeriod'] = this.cyclePeriod.map((v) => v.toJson()).toList();
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
  int minValue;
  int minWeight;
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
  int amount;
  String createdAt;
  String docType;
  int gold;
  String id;
  String mode;
  String otp;
  String paymentId;
  String status;
  String updatedAt;
  String user;

  Installments(
      {this.amount,
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
  int mobile;
  String id;

  User({this.mobile, this.id});

  User.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['id'] = this.id;
    return data;
  }
}
