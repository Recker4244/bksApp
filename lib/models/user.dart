class userdata {
  List<String> gBPBonusEntries;
  String gBPcode;
  List<Addresses> addresses;
  String createAt;
  String deviceToken;
  String dob;
  String docType;
  String email;
  String fname;
  String id;
  String image;
  bool isInvested;
  bool isWhatsapp;
  num joiningBonus;
  String level;
  num mobile;
  String pan;
  String refCode;
  String referenceType;
  List<String> referralBonusEntries;
  String role;
  String updateAt;
  String updatedAt;

  userdata(
      {this.gBPBonusEntries,
      this.gBPcode,
      this.addresses,
      this.createAt,
      this.deviceToken,
      this.dob,
      this.docType,
      this.email,
      this.fname,
      this.id,
      this.image,
      this.isInvested,
      this.isWhatsapp,
      this.joiningBonus,
      this.level,
      this.mobile,
      this.pan,
      this.refCode,
      this.referenceType,
      this.referralBonusEntries,
      this.role,
      this.updateAt,
      this.updatedAt});

  userdata.fromJson(Map<String, dynamic> json) {
    gBPBonusEntries = json['GBPBonusEntries'].cast<String>();
    gBPcode = json['GBPcode'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    createAt = json['createAt'];
    deviceToken = json['deviceToken'];
    dob = json['dob'];
    docType = json['docType'];
    email = json['email'];
    fname = json['fname'];
    id = json['id'];
    image = json['image'];
    isInvested = json['isInvested'];
    isWhatsapp = json['isWhatsapp'];
    joiningBonus = json['joiningBonus'];
    level = json['level'];
    mobile = json['mobile'];
    pan = json['pan'];
    refCode = json['refCode'];
    referenceType = json['referenceType'];
    referralBonusEntries = json['referralBonusEntries'].cast<String>();
    role = json['role'];
    updateAt = json['updateAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GBPBonusEntries'] = this.gBPBonusEntries;
    data['GBPcode'] = this.gBPcode;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['createAt'] = this.createAt;
    data['deviceToken'] = this.deviceToken;
    data['dob'] = this.dob;
    data['docType'] = this.docType;
    data['email'] = this.email;
    data['fname'] = this.fname;
    data['id'] = this.id;
    data['image'] = this.image;
    data['isInvested'] = this.isInvested;
    data['isWhatsapp'] = this.isWhatsapp;
    data['joiningBonus'] = this.joiningBonus;
    data['level'] = this.level;
    data['mobile'] = this.mobile;
    data['pan'] = this.pan;
    data['refCode'] = this.refCode;
    data['referenceType'] = this.referenceType;
    data['referralBonusEntries'] = this.referralBonusEntries;
    data['role'] = this.role;
    data['updateAt'] = this.updateAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Addresses {
  String addressType;
  String createdAt;
  String docType;
  String id;
  bool isDefaultAddress;
  String landMark;
  int pin;
  String updatedAt;
  String user;

  Addresses(
      {this.addressType,
      this.createdAt,
      this.docType,
      this.id,
      this.isDefaultAddress,
      this.landMark,
      this.pin,
      this.updatedAt,
      this.user});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    isDefaultAddress = json['isDefaultAddress'];
    landMark = json['landMark'];
    pin = json['pin'];
    updatedAt = json['updatedAt'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressType'] = this.addressType;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['isDefaultAddress'] = this.isDefaultAddress;
    data['landMark'] = this.landMark;
    data['pin'] = this.pin;
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}

userdata Userdata = userdata();
