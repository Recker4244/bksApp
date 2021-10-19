class Detail {
  bool success;
  DataI data;

  Detail({this.success, this.data});

  Detail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataI.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DataI {
  String status;
  String storeLocation;
  String sId;
  String user;
  String weight;
  String metalGroup;
  String buySellPrice;
  String otp;
  String appointmentDate;
  String appointmentTime;
  String verifier;
  String createdAt;
  String updatedAt;
  int iV;

  DataI(
      {this.status,
        this.storeLocation,
        this.sId,
        this.user,
        this.weight,
        this.metalGroup,
        this.buySellPrice,
        this.otp,
        this.appointmentDate,
        this.appointmentTime,
        this.verifier,
        this.createdAt,
        this.updatedAt,
        this.iV});

  DataI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    storeLocation = json['storeLocation'];
    sId = json['_id'];
    user = json['user'];
    weight = json['weight'].toString();
    metalGroup = json['metalGroup'];
    buySellPrice = json['buySellPrice'];
    otp = json['otp'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    verifier = json['verifier'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['storeLocation'] = this.storeLocation;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['weight'] = this.weight;
    data['metalGroup'] = this.metalGroup;
    data['buySellPrice'] = this.buySellPrice;
    data['otp'] = this.otp;
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentTime'] = this.appointmentTime;
    data['verifier'] = this.verifier;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
