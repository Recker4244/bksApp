class appointment {
  String sId;
  String status;
  String storeLocation;
  User user;
  int weight;
  MetalGroup metalGroup;
  BuySellPrice buySellPrice;
  String otp;
  String appointmentDate;
  String appointmentTime;
  Verifier verifier;
  String createdAt;
  String updatedAt;
  int iV;
  int valuation;

  appointment(
      {this.sId,
      this.status,
      this.storeLocation,
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
      this.iV,
      this.valuation});

  appointment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    storeLocation = json['storeLocation'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    weight = json['weight'];
    metalGroup = json['metalGroup'] != null
        ? new MetalGroup.fromJson(json['metalGroup'])
        : null;
    buySellPrice = json['buySellPrice'] != null
        ? new BuySellPrice.fromJson(json['buySellPrice'])
        : null;
    otp = json['otp'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    verifier = json['verifier'] != null
        ? new Verifier.fromJson(json['verifier'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    valuation = json['valuation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['storeLocation'] = this.storeLocation;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['weight'] = this.weight;
    if (this.metalGroup != null) {
      data['metalGroup'] = this.metalGroup.toJson();
    }
    if (this.buySellPrice != null) {
      data['buySellPrice'] = this.buySellPrice.toJson();
    }
    data['otp'] = this.otp;
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentTime'] = this.appointmentTime;
    if (this.verifier != null) {
      data['verifier'] = this.verifier.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['valuation'] = this.valuation;
    return data;
  }
}

class User {
  String sId;
  String userId;
  String mobile;
  String firstName;
  String lastName;
  String email;
  String deviceToken;
  String status;
  String referalCode;
  String createdDate;
  String modifiedDate;
  String updatedAt;

  User(
      {this.sId,
      this.userId,
      this.mobile,
      this.firstName,
      this.lastName,
      this.email,
      this.deviceToken,
      this.status,
      this.referalCode,
      this.createdDate,
      this.modifiedDate,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['UserId'];
    mobile = json['Mobile'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    deviceToken = json['DeviceToken'];
    status = json['Status'];
    referalCode = json['ReferalCode'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['UserId'] = this.userId;
    data['Mobile'] = this.mobile;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['DeviceToken'] = this.deviceToken;
    data['Status'] = this.status;
    data['ReferalCode'] = this.referalCode;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedDate'] = this.modifiedDate;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class MetalGroup {
  String sId;
  List<Metals> metals;
  String status;
  String karatage;
  num fineness;
  num referenceId;
  String shortName;
  String createdAt;
  String updatedAt;
  int iV;

  MetalGroup(
      {this.sId,
      this.metals,
      this.status,
      this.karatage,
      this.fineness,
      this.referenceId,
      this.shortName,
      this.createdAt,
      this.updatedAt,
      this.iV});

  MetalGroup.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['metals'] != null) {
      metals = new List<Metals>();
      json['metals'].forEach((v) {
        metals.add(new Metals.fromJson(v));
      });
    }
    status = json['status'];
    karatage = json['karatage'];
    fineness = json['fineness'];
    referenceId = json['referenceId'];
    shortName = json['shortName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.metals != null) {
      data['metals'] = this.metals.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['karatage'] = this.karatage;
    data['fineness'] = this.fineness;
    data['referenceId'] = this.referenceId;
    data['shortName'] = this.shortName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Metals {
  String sId;
  String name;
  String icon;
  String createdAt;
  String updatedAt;
  int iV;

  Metals(
      {this.sId,
      this.name,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Metals.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class BuySellPrice {
  String sId;
  Kt24 kt24;
  Kt24 kt22;
  Kt24 kt18;
  Kt24 kt14;
  Kt24 kt10;
  String createdAt;
  String updatedAt;
  int iV;

  BuySellPrice(
      {this.sId,
      this.kt24,
      this.kt22,
      this.kt18,
      this.kt14,
      this.kt10,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BuySellPrice.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    kt24 = json['kt24'] != null ? new Kt24.fromJson(json['kt24']) : null;
    kt22 = json['kt22'] != null ? new Kt24.fromJson(json['kt22']) : null;
    kt18 = json['kt18'] != null ? new Kt24.fromJson(json['kt18']) : null;
    kt14 = json['kt14'] != null ? new Kt24.fromJson(json['kt14']) : null;
    kt10 = json['kt10'] != null ? new Kt24.fromJson(json['kt10']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.kt24 != null) {
      data['kt24'] = this.kt24.toJson();
    }
    if (this.kt22 != null) {
      data['kt22'] = this.kt22.toJson();
    }
    if (this.kt18 != null) {
      data['kt18'] = this.kt18.toJson();
    }
    if (this.kt14 != null) {
      data['kt14'] = this.kt14.toJson();
    }
    if (this.kt10 != null) {
      data['kt10'] = this.kt10.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Kt24 {
  int buy;
  int sell;

  Kt24({this.buy, this.sell});

  Kt24.fromJson(Map<String, dynamic> json) {
    buy = json['buy'];
    sell = json['sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    return data;
  }
}

class Verifier {
  String sId;
  String name;
  String email;
  List<String> address;
  String pan;
  bool isWhatsapp;
  bool isInvested;
  String refCode;
  String gBPcode;
  int mobile;
  String createdAt;
  String updatedAt;
  int iV;

  Verifier(
      {this.sId,
      this.name,
      this.email,
      this.address,
      this.pan,
      this.isWhatsapp,
      this.isInvested,
      this.refCode,
      this.gBPcode,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Verifier.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    address = json['address'].cast<String>();
    pan = json['pan'];
    isWhatsapp = json['isWhatsapp'];
    isInvested = json['isInvested'];
    refCode = json['refCode'];
    gBPcode = json['GBPcode'];
    mobile = json['mobile'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['pan'] = this.pan;
    data['isWhatsapp'] = this.isWhatsapp;
    data['isInvested'] = this.isInvested;
    data['refCode'] = this.refCode;
    data['GBPcode'] = this.gBPcode;
    data['mobile'] = this.mobile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
