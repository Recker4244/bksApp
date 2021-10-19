class userdata {
  String fname;
  String email;
  List<String> addresses;
  String pan;
  bool isWhatsapp;
  bool isInvested;
  String refCode;
  String gBPcode;
  List<String> referralBonusEntries;
  num joiningBonus;
  List<String> gBPBonusEntries;
  String deviceToken;
  String sId;
  int mobile;
  String createdAt;
  String updatedAt;
  int iV;
  String dob;

  userdata(
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

  userdata.fromJson(Map<String, dynamic> json) {
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

userdata Userdata = userdata();
