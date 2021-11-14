class product {
  String createdAt;
  String docType;
  String id;
  List<String> images;
  String name;
  String updatedAt;
  String video;

  product(
      {this.createdAt,
      this.docType,
      this.id,
      this.images,
      this.name,
      this.updatedAt,
      this.video});

  product.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    images = json['images'].cast<String>();
    name = json['name'];
    updatedAt = json['updatedAt'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['images'] = this.images;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    data['video'] = this.video;
    return data;
  }
}
