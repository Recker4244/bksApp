class BuySellList {
  num buy;
  String createdAt;
  String docType;
  String id;
  num sell;
  String updatedAt;

  BuySellList(
      {this.buy,
      this.createdAt,
      this.docType,
      this.id,
      this.sell,
      this.updatedAt});

  BuySellList.fromJson(Map<String, dynamic> json) {
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
