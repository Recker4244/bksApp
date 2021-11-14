class cycles {
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

  cycles(
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

  cycles.fromJson(Map<String, dynamic> json) {
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
