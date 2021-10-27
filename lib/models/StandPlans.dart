class standardplan {
  String mode;
  int duration;
  String sId;
  String planType;
  String name;
  CyclePeriod cyclePeriod;
  String createdAt;
  String updatedAt;
  int iV;

  standardplan(
      {this.mode,
      this.duration,
      this.sId,
      this.planType,
      this.name,
      this.cyclePeriod,
      this.createdAt,
      this.updatedAt,
      this.iV});

  standardplan.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    duration = json['duration'];
    sId = json['id'];
    planType = json['planType'];
    name = json['name'];
    cyclePeriod = json['cyclePeriod'] != null
        ? new CyclePeriod.fromJson(json['cyclePeriod'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['duration'] = this.duration;
    data['id'] = this.sId;
    data['planType'] = this.planType;
    data['name'] = this.name;
    if (this.cyclePeriod != null) {
      data['cyclePeriod'] = this.cyclePeriod.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CyclePeriod {
  String status;
  String sId;
  String name;
  int graceperiod;
  int minValue;
  int minWeight;
  String shortName;
  int cycle;
  String createdAt;
  String updatedAt;
  int iV;

  CyclePeriod(
      {this.status,
      this.sId,
      this.name,
      this.graceperiod,
      this.minValue,
      this.minWeight,
      this.shortName,
      this.cycle,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CyclePeriod.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['id'];
    name = json['name'];
    graceperiod = json['graceperiod'];
    minValue = json['minValue'];
    minWeight = json['minWeight'];
    shortName = json['shortName'];
    cycle = json['cycle'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.sId;
    data['name'] = this.name;
    data['graceperiod'] = this.graceperiod;
    data['minValue'] = this.minValue;
    data['minWeight'] = this.minWeight;
    data['shortName'] = this.shortName;
    data['cycle'] = this.cycle;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
