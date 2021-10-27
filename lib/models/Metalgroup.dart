class MetalGroup {
  List<Metals> metals;
  String status;
  String sId;
  String karatage;
  num fineness;
  num referenceId;
  String shortName;
  String createdAt;
  String updatedAt;
  int iV;

  MetalGroup(
      {this.metals,
      this.status,
      this.sId,
      this.karatage,
      this.fineness,
      this.referenceId,
      this.shortName,
      this.createdAt,
      this.updatedAt,
      this.iV});

  MetalGroup.fromJson(Map<String, dynamic> json) {
    if (json['metals'] != null) {
      metals = new List<Metals>();
      json['metals'].forEach((v) {
        metals.add(new Metals.fromJson(v));
      });
    }
    status = json['status'];
    sId = json['id'];
    karatage = json['karatage'];
    fineness = json['fineness'];
    referenceId = json['referenceId'];
    shortName = json['shortName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metals != null) {
      data['metals'] = this.metals.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['id'] = this.sId;
    data['karatage'] = this.karatage;
    data['fineness'] = this.fineness;
    data['referenceId'] = this.referenceId;
    data['shortName'] = this.shortName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Metals {
  String sId;
  String name;
  String icon;
  String createdAt;
  String updatedAt;
  int iV;

  Metals(
      {this.sId,
      this.name,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Metals.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    name = json['name'];
    icon = json['icon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
