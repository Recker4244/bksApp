class subPlan {
  String sId;
  String planType;
  String name;
  String cyclePeriod;
  int duration;
  String createdAt;
  String updatedAt;
  int iV;

  subPlan(
      {this.sId,
      this.planType,
      this.name,
      this.cyclePeriod,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.iV});

  subPlan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planType = json['planType'];
    name = json['name'];
    cyclePeriod = json['cyclePeriod'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['planType'] = this.planType;
    data['name'] = this.name;
    data['cyclePeriod'] = this.cyclePeriod;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

subPlan subplan = subPlan();
