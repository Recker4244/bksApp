class category {
  String categoryName;
  String createdAt;
  String docType;
  String id;
  List<String> images;
  String updatedAt;
  String video;

  category(
      {this.categoryName,
      this.createdAt,
      this.docType,
      this.id,
      this.images,
      this.updatedAt,
      this.video});

  category.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    images = json['images'].cast<String>();
    updatedAt = json['updatedAt'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['images'] = this.images;
    data['updatedAt'] = this.updatedAt;
    data['video'] = this.video;
    return data;
  }
}
