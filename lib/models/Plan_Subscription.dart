class PlanSubscriptions {
  bool success;
  DataS data;

  PlanSubscriptions({this.success, this.data});

  PlanSubscriptions.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataS.fromJson(json['data']) : null;
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

class DataS {
  List<String> installments;
  String status;
  int unpaidSkips;
  int skipCount;
  int unpaidInvestments;
  String sId;
  String user;
  String plan;
  String createdAt;
  String updatedAt;
  int iV;

  DataS(
      {this.installments,
        this.status,
        this.unpaidSkips,
        this.skipCount,
        this.unpaidInvestments,
        this.sId,
        this.user,
        this.plan,
        this.createdAt,
        this.updatedAt,
        this.iV});

  DataS.fromJson(Map<String, dynamic> json) {
    installments = json['installments'].cast<String>();
    status = json['status'];
    unpaidSkips = json['unpaidSkips'];
    skipCount = json['skipCount'];
    unpaidInvestments = json['unpaidInvestments'];
    sId = json['_id'];
    user = json['user'];
    plan = json['plan'];
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
    data['plan'] = this.plan;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
