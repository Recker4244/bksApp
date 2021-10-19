class BuySellList {
  String sId;
  num buy;
  num sell;
  String createdAt;
  String updatedAt;
  int iV;

  BuySellList(
      {this.sId, this.buy, this.sell, this.createdAt, this.updatedAt, this.iV});

  BuySellList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    buy = json['buy'];
    sell = json['sell'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
