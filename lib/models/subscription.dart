class subscription {
  String sId;
  List<Installments> installments;
  String status;
  int unpaidSkips;
  int skipCount;
  int unpaidInvestments;
  String maturityDate;
  num planBonus;
  User user;
  Plan plan;
  String createdAt;
  String updatedAt;
  int iV;
  num savedAmount;
  int savedWeight;
  int totalBonus;

  subscription(
      {this.sId,
      this.installments,
      this.status,
      this.unpaidSkips,
      this.skipCount,
      this.unpaidInvestments,
      this.maturityDate,
      this.planBonus,
      this.user,
      this.plan,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.savedAmount,
      this.savedWeight,
      this.totalBonus});

  subscription.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    if (json['installments'] != null) {
      installments = new List<Installments>();
      json['installments'].forEach((v) {
        installments.add(new Installments.fromJson(v));
      });
    }
    status = json['status'];
    unpaidSkips = json['unpaidSkips'];
    skipCount = json['skipCount'];
    unpaidInvestments = json['unpaidInvestments'];
    maturityDate = json['maturityDate'];
    planBonus = json['planBonus'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    savedAmount = json['savedAmount'];
    savedWeight = json['savedWeight'];
    totalBonus = json['totalBonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    if (this.installments != null) {
      data['installments'] = this.installments.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['unpaidSkips'] = this.unpaidSkips;
    data['skipCount'] = this.skipCount;
    data['unpaidInvestments'] = this.unpaidInvestments;
    data['maturityDate'] = this.maturityDate;
    data['planBonus'] = this.planBonus;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.plan != null) {
      data['plan'] = this.plan.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['savedAmount'] = this.savedAmount;
    data['savedWeight'] = this.savedWeight;
    data['totalBonus'] = this.totalBonus;
    return data;
  }
}

class Installments {
  String sId;
  String mode;
  num amount;
  num gold;
  String otp;
  String paymentId;
  String status;
  String createdAt;
  String updatedAt;
  int iV;

  Installments(
      {this.sId,
      this.mode,
      this.amount,
      this.gold,
      this.otp,
      this.paymentId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Installments.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    mode = json['mode'];
    amount = json['amount'];
    gold = json['gold'];
    otp = json['otp'];
    paymentId = json['paymentId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['mode'] = this.mode;
    data['amount'] = this.amount;
    data['gold'] = this.gold;
    data['otp'] = this.otp;
    data['paymentId'] = this.paymentId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String sId;
  int mobile;

  User({this.sId, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['mobile'] = this.mobile;
    return data;
  }
}

class Plan {
  String sId;
  String mode;
  int duration;
  String planType;
  String name;
  String cyclePeriod;
  String createdAt;
  String updatedAt;
  int iV;

  Plan(
      {this.sId,
      this.mode,
      this.duration,
      this.planType,
      this.name,
      this.cyclePeriod,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Plan.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    mode = json['mode'];
    duration = json['duration'];
    planType = json['planType'];
    name = json['name'];
    cyclePeriod = json['cyclePeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['mode'] = this.mode;
    data['duration'] = this.duration;
    data['planType'] = this.planType;
    data['name'] = this.name;
    data['cyclePeriod'] = this.cyclePeriod;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
