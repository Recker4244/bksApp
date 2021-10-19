class category {
  String sId;
  String categoryName;
  String img1;
  String img2;
  String img3;
  String video;
  String status;

  category(
      {this.sId,
      this.categoryName,
      this.img1,
      this.img2,
      this.img3,
      this.video,
      this.status});

  category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['category_name'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    video = json['video'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category_name'] = this.categoryName;
    data['img1'] = this.img1;
    data['img2'] = this.img2;
    data['img3'] = this.img3;
    data['video'] = this.video;
    data['status'] = this.status;
    return data;
  }
}
