class FlexiSubscribe {
  bool success;
  DataFS data;

  FlexiSubscribe({this.success, this.data});

  FlexiSubscribe.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataFS.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DataFS {
  List<String> installments;
  String status;
  int unpaidSkips;
  int skipCount;
  int unpaidInvestments;
  String sId;
  String user;
  CustomPlan customPlan;
  String createdAt;
  String updatedAt;
  int iV;

  DataFS(
      {this.installments,
        this.status,
        this.unpaidSkips,
        this.skipCount,
        this.unpaidInvestments,
        this.sId,
        this.user,
        this.customPlan,
        this.createdAt,
        this.updatedAt,
        this.iV});

  DataFS.fromJson(Map<String, dynamic> json) {
    installments = json['installments'].cast<String>();
    status = json['status'];
    unpaidSkips = json['unpaidSkips'];
    skipCount = json['skipCount'];
    unpaidInvestments = json['unpaidInvestments'];
    sId = json['_id'];
    user = json['user'];
    customPlan = json['customPlan'] != null
        ? new CustomPlan.fromJson(json['customPlan'])
        : null;
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
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.customPlan != null) {
      data['customPlan'] = this.customPlan.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CustomPlan {
  String mode;
  int duration;
  String sId;
  String name;
  String planType;
  CyclePeriod cyclePeriod;
  String createdAt;
  String updatedAt;

  CustomPlan(
      {this.mode,
        this.duration,
        this.sId,
        this.name,
        this.planType,
        this.cyclePeriod,
        this.createdAt,
        this.updatedAt});

  CustomPlan.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    duration = json['duration'];
    sId = json['_id'];
    name = json['name'];
    planType = json['planType'];
    cyclePeriod = json['cyclePeriod'] != null
        ? new CyclePeriod.fromJson(json['cyclePeriod'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['duration'] = this.duration;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['planType'] = this.planType;
    if (this.cyclePeriod != null) {
      data['cyclePeriod'] = this.cyclePeriod.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CyclePeriod {
  String status;
  String sId;
  int cycle;
  String name;
  int graceperiod;
  int minValue;
  int minWeight;
  String shortName;
  String createdAt;
  String updatedAt;
  int iV;

  CyclePeriod(
      {this.status,
        this.sId,
        this.cycle,
        this.name,
        this.graceperiod,
        this.minValue,
        this.minWeight,
        this.shortName,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CyclePeriod.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    cycle = json['cycle'];
    name = json['name'];
    graceperiod = json['graceperiod'];
    minValue = json['minValue'];
    minWeight = json['minWeight'];
    shortName = json['shortName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['cycle'] = this.cycle;
    data['name'] = this.name;
    data['graceperiod'] = this.graceperiod;
    data['minValue'] = this.minValue;
    data['minWeight'] = this.minWeight;
    data['shortName'] = this.shortName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
