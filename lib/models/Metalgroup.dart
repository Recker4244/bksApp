class MetalGroup {
  String createdAt;
  String docType;
  num fineness;
  String id;
  String karatage;
  List<Metals> metals;
  num referenceId;
  String shortName;
  String updatedAt;

  MetalGroup(
      {this.createdAt,
      this.docType,
      this.fineness,
      this.id,
      this.karatage,
      this.metals,
      this.referenceId,
      this.shortName,
      this.updatedAt});

  MetalGroup.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    fineness = json['fineness'];
    id = json['id'];
    karatage = json['karatage'];
    if (json['metals'] != null) {
      metals = new List<Metals>();
      json['metals'].forEach((v) {
        metals.add(new Metals.fromJson(v));
      });
    }
    referenceId = json['referenceId'];
    shortName = json['shortName'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['fineness'] = this.fineness;
    data['id'] = this.id;
    data['karatage'] = this.karatage;
    if (this.metals != null) {
      data['metals'] = this.metals.map((v) => v.toJson()).toList();
    }
    data['referenceId'] = this.referenceId;
    data['shortName'] = this.shortName;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Metals {
  String createdAt;
  String docType;
  String icon;
  String id;
  String name;
  String updatedAt;

  Metals(
      {this.createdAt,
      this.docType,
      this.icon,
      this.id,
      this.name,
      this.updatedAt});

  Metals.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
