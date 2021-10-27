class cycles {
  String status;
  String sId;
  String name;
  int graceperiod;
  num minValue;
  num minWeight;
  String shortName;
  int cycle;
  String createdAt;
  String updatedAt;
  int iV;

  cycles(
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

  cycles.fromJson(Map<String, dynamic> json) {
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
