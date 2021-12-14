class slider {
  String sId;
  String name;
  String image;
  String offer;
  String status;
  String createdAt;
  String updatedAt;
  int iV;

  slider(
      {this.sId,
      this.name,
      this.image,
      this.offer,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  slider.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    offer = json['offer'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['offer'] = this.offer;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
