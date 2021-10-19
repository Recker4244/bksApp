class bankDetails {
  String sId;
  String accountnum;
  String iFSC;
  String bank;
  String branch;
  String user;
  String createdAt;
  String updatedAt;
  int iV;

  bankDetails(
      {this.sId,
      this.accountnum,
      this.iFSC,
      this.bank,
      this.branch,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  bankDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accountnum = json['Accountnum'];
    iFSC = json['IFSC'];
    bank = json['Bank'];
    branch = json['Branch'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Accountnum'] = this.accountnum;
    data['IFSC'] = this.iFSC;
    data['Bank'] = this.bank;
    data['Branch'] = this.branch;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

bankDetails bankdetail = bankDetails();
