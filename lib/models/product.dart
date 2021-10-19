class product {
  List<String> images;
  String sId;
  String name;
  String video;
  String createdAt;
  String updatedAt;
  int iV;

  product(
      {this.images,
      this.sId,
      this.name,
      this.video,
      this.createdAt,
      this.updatedAt,
      this.iV});

  product.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    video = json['video'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['video'] = this.video;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
