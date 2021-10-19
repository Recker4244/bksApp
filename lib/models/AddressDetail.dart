class Address {
  String addressType;
  bool isDefaultAddress;
  String sId;
  User user;
  int pin;
  String landMark;
  String status;
  String createdAt;
  String updatedAt;
  int iV;

  Address(
      {this.addressType,
        this.isDefaultAddress,
        this.sId,
        this.user,
        this.pin,
        this.landMark,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Address.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    isDefaultAddress = json['isDefaultAddress'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    pin = json['pin'];
    landMark = json['landMark'];
    status = json['status'];
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
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String fname;
  String email;
  List<String> address;
  String pan;
  bool isWhatsapp;
  bool isInvested;
  String refCode;
  String gBPcode;
  List<String> referralBonusEntries;
  int joiningBonus;
  List<String> gBPBonusEntries;
  String sId;
  int mobile;
  String createdAt;
  String updatedAt;
  int iV;
  String dob;

  User(
      {this.fname,
        this.email,
        this.address,
        this.pan,
        this.isWhatsapp,
        this.isInvested,
        this.refCode,
        this.gBPcode,
        this.referralBonusEntries,
        this.joiningBonus,
        this.gBPBonusEntries,
        this.sId,
        this.mobile,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.dob});

  User.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    email = json['email'];
    address = json['address'].cast<String>();
    pan = json['pan'];
    isWhatsapp = json['isWhatsapp'];
    isInvested = json['isInvested'];
    refCode = json['refCode'];
    gBPcode = json['GBPcode'];
    referralBonusEntries = json['referralBonusEntries'].cast<String>();
    joiningBonus = json['joiningBonus'];
    gBPBonusEntries = json['GBPBonusEntries'].cast<String>();
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
    data['address'] = this.address;
    data['pan'] = this.pan;
    data['isWhatsapp'] = this.isWhatsapp;
    data['isInvested'] = this.isInvested;
    data['refCode'] = this.refCode;
    data['GBPcode'] = this.gBPcode;
    data['referralBonusEntries'] = this.referralBonusEntries;
    data['joiningBonus'] = this.joiningBonus;
    data['GBPBonusEntries'] = this.gBPBonusEntries;
    data['_id'] = this.sId;
    data['mobile'] = this.mobile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['dob'] = this.dob;
    return data;
  }
}
