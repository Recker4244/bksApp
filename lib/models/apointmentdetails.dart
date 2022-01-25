class AppointmentDetails {
  String appointmentDate;
  String appointmentTime;
  BuySellPrice buySellPrice;
  String createdAt;
  String docType;
  String id;
  String opt;
  String status;
  String storeLocation;
  String updatedAt;
  User user;
  int weight;
  int valuation;

  AppointmentDetails(
      {this.appointmentDate,
      this.appointmentTime,
      this.buySellPrice,
      this.createdAt,
      this.docType,
      this.id,
      this.opt,
      this.status,
      this.storeLocation,
      this.updatedAt,
      this.user,
      this.weight,
      this.valuation});

  AppointmentDetails.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    buySellPrice = json['buySellPrice'] != null
        ? new BuySellPrice.fromJson(json['buySellPrice'])
        : null;
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    opt = json['opt'];
    status = json['status'];
    storeLocation = json['storeLocation'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    weight = json['weight'];
    valuation = json['valuation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentTime'] = this.appointmentTime;
    if (this.buySellPrice != null) {
      data['buySellPrice'] = this.buySellPrice.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['opt'] = this.opt;
    data['status'] = this.status;
    data['storeLocation'] = this.storeLocation;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['weight'] = this.weight;
    data['valuation'] = this.valuation;
    return data;
  }
}

class BuySellPrice {
  int buy;
  String createdAt;
  String docType;
  String id;
  int sell;
  String updatedAt;

  BuySellPrice(
      {this.buy,
      this.createdAt,
      this.docType,
      this.id,
      this.sell,
      this.updatedAt});

  BuySellPrice.fromJson(Map<String, dynamic> json) {
    buy = json['buy'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    sell = json['sell'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy'] = this.buy;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['sell'] = this.sell;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class User {
  String id;
  String fname;
  String email;
  int mobile;

  User({this.id, this.fname, this.email, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}
