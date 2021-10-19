class Video {
  String sId;
  String language;
  String category;
  String video;
  String createdAt;
  String updatedAt;
  int iV;

  Video(
      {this.sId,
      this.language,
      this.category,
      this.video,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Video.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    language = json['language'];
    category = json['category'];
    video = json['video'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['language'] = this.language;
    data['category'] = this.category;
    data['video'] = this.video;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
