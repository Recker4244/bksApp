class standardplan {
  num bonus;
  String createdAt;
  CyclePeriod cyclePeriod;
  String docType;
  int duration;
  String id;
  String mode;
  String name;
  String planType;
  String updatedAt;

  standardplan(
      {this.bonus,
      this.createdAt,
      this.cyclePeriod,
      this.docType,
      this.duration,
      this.id,
      this.mode,
      this.name,
      this.planType,
      this.updatedAt});

  standardplan.fromJson(Map<String, dynamic> json) {
    bonus = json['bonus'];
    createdAt = json['createdAt'];
    cyclePeriod = json['cyclePeriod'] != null
        ? new CyclePeriod.fromJson(json['cyclePeriod'])
        : null;
    docType = json['docType'];
    duration = json['duration'];
    id = json['id'];
    mode = json['mode'];
    name = json['name'];
    planType = json['planType'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bonus'] = this.bonus;
    data['createdAt'] = this.createdAt;
    if (this.cyclePeriod != null) {
      data['cyclePeriod'] = this.cyclePeriod.toJson();
    }
    data['docType'] = this.docType;
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['mode'] = this.mode;
    data['name'] = this.name;
    data['planType'] = this.planType;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CyclePeriod {
  String createdAt;
  String docType;
  int graceperiod;
  String id;
  int minValue;
  int minWeight;
  String name;
  String shortName;
  String updatedAt;

  CyclePeriod(
      {this.createdAt,
      this.docType,
      this.graceperiod,
      this.id,
      this.minValue,
      this.minWeight,
      this.name,
      this.shortName,
      this.updatedAt});

  CyclePeriod.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    graceperiod = json['graceperiod'];
    id = json['id'];
    minValue = json['minValue'];
    minWeight = json['minWeight'];
    name = json['name'];
    shortName = json['shortName'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['graceperiod'] = this.graceperiod;
    data['id'] = this.id;
    data['minValue'] = this.minValue;
    data['minWeight'] = this.minWeight;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
