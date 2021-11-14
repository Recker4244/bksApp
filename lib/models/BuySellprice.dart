class buysellprice {
  String buy;
  String sell;
  num buyChange;
  num sellChange;

  buysellprice({this.buy, this.sell, this.buyChange, this.sellChange});

  buysellprice.fromJson(Map<String, dynamic> json) {
    buy = json['buy'];
    sell = json['sell'];
    buyChange = json['buyChange'];
    sellChange = json['sellChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    data['buyChange'] = this.buyChange;
    data['sellChange'] = this.sellChange;
    return data;
  }
}
