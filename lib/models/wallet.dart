class walletBalance {
  bool success;
  Data data;

  walletBalance({this.success, this.data});

  walletBalance.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String sId;
  String user;
  int gold;
  List<Transactions> transactions;
  String createdAt;
  String updatedAt;
  int iV;
  Bank bank;

  Data(
      {this.sId,
      this.user,
      this.gold,
      this.transactions,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.bank});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    gold = json['gold'];
    if (json['transactions'] != null) {
      transactions = new List<Transactions>();
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    bank = json['bank'] != null ? new Bank.fromJson(json['bank']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['gold'] = this.gold;
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.bank != null) {
      data['bank'] = this.bank.toJson();
    }
    return data;
  }
}

class Transactions {
  String sId;
  String paymentId;
  int amount;
  String status;

  Transactions({this.sId, this.paymentId, this.amount, this.status});

  Transactions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    paymentId = json['paymentId'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['paymentId'] = this.paymentId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}

class Bank {
  String sId;
  String accountnum;
  String iFSC;
  String bank;
  String branch;
  String user;
  String createdAt;
  String updatedAt;
  int iV;

  Bank(
      {this.sId,
      this.accountnum,
      this.iFSC,
      this.bank,
      this.branch,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Bank.fromJson(Map<String, dynamic> json) {
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
