class referral {
  String bonus;
  String sId;
  User user;
  User refereedBy;
  Subscription subscription;
  String createdAt;
  String updatedAt;
  int iV;

  referral(
      {this.bonus,
      this.sId,
      this.user,
      this.refereedBy,
      this.subscription,
      this.createdAt,
      this.updatedAt,
      this.iV});

  referral.fromJson(Map<String, dynamic> json) {
    bonus = (json['bonus']).toString();
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    refereedBy = json['refereedBy'] != null
        ? new User.fromJson(json['refereedBy'])
        : null;
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bonus'] = this.bonus;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.refereedBy != null) {
      data['refereedBy'] = this.refereedBy.toJson();
    }
    if (this.subscription != null) {
      data['subscription'] = this.subscription.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String fname;
  String email;
  String sId;
  int mobile;

  User({this.fname, this.email, this.sId, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    email = json['email'];
    sId = json['_id'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['_id'] = this.sId;
    data['mobile'] = this.mobile;
    return data;
  }
}

class Subscription {
  List<String> installments;
  String status;
  int unpaidSkips;
  int skipCount;
  int unpaidInvestments;
  String maturityDate;
  String sId;
  String user;
  String address;
  Plan plan;
  String createdAt;
  String updatedAt;
  int iV;

  Subscription(
      {this.installments,
      this.status,
      this.unpaidSkips,
      this.skipCount,
      this.unpaidInvestments,
      this.maturityDate,
      this.sId,
      this.user,
      this.address,
      this.plan,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Subscription.fromJson(Map<String, dynamic> json) {
    installments = json['installments'].cast<String>();
    status = json['status'];
    unpaidSkips = json['unpaidSkips'];
    skipCount = json['skipCount'];
    unpaidInvestments = json['unpaidInvestments'];
    maturityDate = json['maturityDate'];
    sId = json['_id'];
    user = json['user'];
    address = json['address'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['installments'] = this.installments;
    data['status'] = this.status;
    data['unpaidSkips'] = this.unpaidSkips;
    data['skipCount'] = this.skipCount;
    data['unpaidInvestments'] = this.unpaidInvestments;
    data['maturityDate'] = this.maturityDate;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['address'] = this.address;
    if (this.plan != null) {
      data['plan'] = this.plan.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Plan {
  String sId;
  String name;

  Plan({this.sId, this.name});

  Plan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
