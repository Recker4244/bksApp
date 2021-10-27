class buysellprice {
  String sId;
  num buy;
  num sell;
  num buyChange;
  num sellChange;

  buysellprice(
      {this.sId, this.buy, this.sell, this.buyChange, this.sellChange});

  buysellprice.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    buy = json['buy'];
    sell = json['sell'];
    buyChange = json['buyChange'];
    sellChange = json['sellChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    data['buyChange'] = this.buyChange;
    data['sellChange'] = this.sellChange;
    return data;
  }
}
