class order {
  String sId;
  String status;
  String consignment;
  int redeemGoldApplied;
  int instantGoldApplied;
  String otp;
  num totalCharges;
  User user;
  Cart cart;
  String transactions;
  Address address;
  String deliveryCharge;
  BuySell buySell;
  String createdAt;
  String updatedAt;
  int iV;
  int amount;

  order(
      {this.sId,
      this.status,
      this.consignment,
      this.redeemGoldApplied,
      this.instantGoldApplied,
      this.otp,
      this.totalCharges,
      this.user,
      this.cart,
      this.transactions,
      this.address,
      this.deliveryCharge,
      this.buySell,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.amount});

  order.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    status = json['status'];
    consignment = json['consignment'];
    redeemGoldApplied = json['redeemGoldApplied'];
    instantGoldApplied = json['instantGoldApplied'];
    otp = json['otp'];
    totalCharges = json['totalCharges'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    transactions = json['transactions'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    deliveryCharge = json['deliveryCharge'];
    buySell =
        json['buySell'] != null ? new BuySell.fromJson(json['buySell']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['status'] = this.status;
    data['consignment'] = this.consignment;
    data['redeemGoldApplied'] = this.redeemGoldApplied;
    data['instantGoldApplied'] = this.instantGoldApplied;
    data['otp'] = this.otp;
    data['totalCharges'] = this.totalCharges;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    data['transactions'] = this.transactions;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['deliveryCharge'] = this.deliveryCharge;
    if (this.buySell != null) {
      data['buySell'] = this.buySell.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['amount'] = this.amount;
    return data;
  }
}

class User {
  String sId;
  String fname;
  String email;
  List<String> address;
  String pan;
  bool isWhatsapp;
  bool isInvested;
  String refCode;
  String gBPcode;
  List<String> referralBonusEntries;
  double joiningBonus;
  List<String> gBPBonusEntries;
  int mobile;
  String createdAt;
  String updatedAt;
  int iV;
  String dob;
  String referral;
  List<String> addresses;
  String deviceToken;

  User(
      {this.sId,
      this.fname,
      this.email,
      this.address,
      this.pan,
      this.isWhatsapp,
      this.isInvested,
      this.refCode,
      this.gBPcode,
      this.referralBonusEntries,
      this.joiningBonus,
      this.gBPBonusEntries,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.dob,
      this.referral,
      this.addresses,
      this.deviceToken});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    fname = json['fname'];
    email = json['email'];
    address = json['address'].cast<String>();
    pan = json['pan'];
    isWhatsapp = json['isWhatsapp'];
    isInvested = json['isInvested'];
    refCode = json['refCode'];
    gBPcode = json['GBPcode'];
    referralBonusEntries = json['referralBonusEntries'].cast<String>();
    joiningBonus = json['joiningBonus'];
    gBPBonusEntries = json['GBPBonusEntries'].cast<String>();
    mobile = json['mobile'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    dob = json['dob'];
    referral = json['referral'];
    addresses = json['addresses'].cast<String>();
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['address'] = this.address;
    data['pan'] = this.pan;
    data['isWhatsapp'] = this.isWhatsapp;
    data['isInvested'] = this.isInvested;
    data['refCode'] = this.refCode;
    data['GBPcode'] = this.gBPcode;
    data['referralBonusEntries'] = this.referralBonusEntries;
    data['joiningBonus'] = this.joiningBonus;
    data['GBPBonusEntries'] = this.gBPBonusEntries;
    data['mobile'] = this.mobile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['dob'] = this.dob;
    data['referral'] = this.referral;
    data['addresses'] = this.addresses;
    data['deviceToken'] = this.deviceToken;
    return data;
  }
}

class Cart {
  String sId;
  String user;
  List<Items> items;
  String createdAt;
  String updatedAt;
  int iV;

  Cart(
      {this.sId,
      this.user,
      this.items,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Cart.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    user = json['user'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['user'] = this.user;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Items {
  String sId;
  String itemDetail;
  int quantity;

  Items({this.sId, this.itemDetail, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    itemDetail = json['itemDetail'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['itemDetail'] = this.itemDetail;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Address {
  String sId;
  String addressType;
  bool isDefaultAddress;
  String user;
  int pin;
  String landMark;
  String createdAt;
  String updatedAt;
  int iV;

  Address(
      {this.sId,
      this.addressType,
      this.isDefaultAddress,
      this.user,
      this.pin,
      this.landMark,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    addressType = json['addressType'];
    isDefaultAddress = json['isDefaultAddress'];
    user = json['user'];
    pin = json['pin'];
    landMark = json['landMark'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['addressType'] = this.addressType;
    data['isDefaultAddress'] = this.isDefaultAddress;
    data['user'] = this.user;
    data['pin'] = this.pin;
    data['landMark'] = this.landMark;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class BuySell {
  String sId;

  BuySell({this.sId});

  BuySell.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    return data;
  }
}
