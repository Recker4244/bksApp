class offerList {
  String createdAt;
  String docType;
  String id;
  String image;
  String name;
  String type;
  String typeId;
  String updatedAt;

  offerList(
      {this.createdAt,
      this.docType,
      this.id,
      this.image,
      this.name,
      this.type,
      this.typeId,
      this.updatedAt});

  offerList.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    type = json['type'];
    typeId = json['typeId'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['type'] = this.type;
    data['typeId'] = this.typeId;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
