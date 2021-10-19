class Transaction {
  String mode;
  int amount;
  bool instantGoldApplied;
  String sId;
  String paymentId;
  String status;
  String deleveryAgent;
  String createdAt;
  String updatedAt;
  int iV;

  Transaction(
      {this.mode,
      this.amount,
      this.instantGoldApplied,
      this.sId,
      this.paymentId,
      this.status,
      this.deleveryAgent,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Transaction.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    amount = json['amount'];
    instantGoldApplied = json['instantGoldApplied'];
    sId = json['_id'];
    paymentId = json['paymentId'];
    status = json['status'];
    deleveryAgent = json['deleveryAgent'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['amount'] = this.amount;
    data['instantGoldApplied'] = this.instantGoldApplied;
    data['_id'] = this.sId;
    data['paymentId'] = this.paymentId;
    data['status'] = this.status;
    data['deleveryAgent'] = this.deleveryAgent;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
