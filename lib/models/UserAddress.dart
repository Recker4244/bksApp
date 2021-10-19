class UserAddress {
  String addressType;
  bool isDefaultAddress;
  String sId;
  User user;
  int pin;
  String landMark;
  String createdAt;
  String updatedAt;
  int iV;

  UserAddress(
      {this.addressType,
      this.isDefaultAddress,
      this.sId,
      this.user,
      this.pin,
      this.landMark,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserAddress.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    isDefaultAddress = json['isDefaultAddress'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    pin = json['pin'];
    landMark = json['landMark'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressType'] = this.addressType;
    data['isDefaultAddress'] = this.isDefaultAddress;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['pin'] = this.pin;
    data['landMark'] = this.landMark;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String fname;
  String email;
  List<String> addresses;
  String pan;
  bool isWhatsapp;
  bool isInvested;
  String refCode;
  String gBPcode;
  List<String> referralBonusEntries;
  int joiningBonus;
  List<String> gBPBonusEntries;
  String deviceToken;
  String sId;
  int mobile;
  String createdAt;
  String updatedAt;
  int iV;
  String dob;

  User(
      {this.fname,
      this.email,
      this.addresses,
      this.pan,
      this.isWhatsapp,
      this.isInvested,
      this.refCode,
      this.gBPcode,
      this.referralBonusEntries,
      this.joiningBonus,
      this.gBPBonusEntries,
      this.deviceToken,
      this.sId,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.dob});

  User.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    email = json['email'];
    addresses = json['addresses'].cast<String>();
    pan = json['pan'];
    isWhatsapp = json['isWhatsapp'];
    isInvested = json['isInvested'];
    refCode = json['refCode'];
    gBPcode = json['GBPcode'];
    referralBonusEntries = json['referralBonusEntries'].cast<String>();
    joiningBonus = json['joiningBonus'];
    gBPBonusEntries = json['GBPBonusEntries'].cast<String>();
    deviceToken = json['deviceToken'];
    sId = json['_id'];
    mobile = json['mobile'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['addresses'] = this.addresses;
    data['pan'] = this.pan;
    data['isWhatsapp'] = this.isWhatsapp;
    data['isInvested'] = this.isInvested;
    data['refCode'] = this.refCode;
    data['GBPcode'] = this.gBPcode;
    data['referralBonusEntries'] = this.referralBonusEntries;
    data['joiningBonus'] = this.joiningBonus;
    data['GBPBonusEntries'] = this.gBPBonusEntries;
    data['deviceToken'] = this.deviceToken;
    data['_id'] = this.sId;
    data['mobile'] = this.mobile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['dob'] = this.dob;
    return data;
  }
}
