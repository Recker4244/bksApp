class buysellprice {
  String id;
  num buy;
  num sell;
  num buyChange;
  num sellChange;

  buysellprice({this.id, this.buy, this.sell, this.buyChange, this.sellChange});

  buysellprice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buy = json['buy'];
    sell = json['sell'];
    buyChange = json['buyChange'];
    sellChange = json['sellChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    data['buyChange'] = this.buyChange;
    data['sellChange'] = this.sellChange;
    return data;
  }
}
