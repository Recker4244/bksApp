class Installment {
  bool success;
  DataIN data;

  Installment({this.success, this.data});

  Installment.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataIN.fromJson(json['data']) : null;
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

class DataIN {
  String mode;
  String amount;
  int gold;
  int bonusSaved;
  String otp;
  String sId;
  String paymentId;
  String status;
  String createdAt;
  String updatedAt;
  int iV;

  DataIN(
      {this.mode,
        this.amount,
        this.gold,
        this.bonusSaved,
        this.otp,
        this.sId,
        this.paymentId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  DataIN.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    amount = json['amount'].toString();
    gold = json['gold'];
    bonusSaved = json['bonusSaved'];
    otp = json['otp'];
    sId = json['_id'];
    paymentId = json['paymentId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['amount'] = this.amount;
    data['gold'] = this.gold;
    data['bonusSaved'] = this.bonusSaved;
    data['otp'] = this.otp;
    data['_id'] = this.sId;
    data['paymentId'] = this.paymentId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
