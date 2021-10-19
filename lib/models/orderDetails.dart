class orderdetails {
  String status;
  String consignment;
  int redeemGoldApplied;
  int instantGoldApplied;
  String otp;
  double totalCharges;
  String sId;
  User user;
  Cart cart;
  Transactions transactions;
  String address;
  DeliveryCharge deliveryCharge;
  BuySell buySell;
  String createdAt;
  String updatedAt;
  int iV;

  orderdetails(
      {this.status,
      this.consignment,
      this.redeemGoldApplied,
      this.instantGoldApplied,
      this.otp,
      this.totalCharges,
      this.sId,
      this.user,
      this.cart,
      this.transactions,
      this.address,
      this.deliveryCharge,
      this.buySell,
      this.createdAt,
      this.updatedAt,
      this.iV});

  orderdetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    consignment = json['consignment'];
    redeemGoldApplied = json['redeemGoldApplied'];
    instantGoldApplied = json['instantGoldApplied'];
    otp = json['otp'];
    totalCharges = json['totalCharges'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    transactions = json['transactions'] != null
        ? new Transactions.fromJson(json['transactions'])
        : null;
    address = json['address'];
    deliveryCharge = json['deliveryCharge'] != null
        ? new DeliveryCharge.fromJson(json['deliveryCharge'])
        : null;
    buySell =
        json['buySell'] != null ? new BuySell.fromJson(json['buySell']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['consignment'] = this.consignment;
    data['redeemGoldApplied'] = this.redeemGoldApplied;
    data['instantGoldApplied'] = this.instantGoldApplied;
    data['otp'] = this.otp;
    data['totalCharges'] = this.totalCharges;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions.toJson();
    }
    data['address'] = this.address;
    if (this.deliveryCharge != null) {
      data['deliveryCharge'] = this.deliveryCharge.toJson();
    }
    if (this.buySell != null) {
      data['buySell'] = this.buySell.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String fname;
  String email;
  List<String> addresses;
  String pan;
  bool isWhatsapp;
  bool isInvested;
  String refCode;
  String gBPcode;
  List<String> referralBonusEntries;
  double joiningBonus;
  List<String> gBPBonusEntries;
  String deviceToken;
  String sId;
  List<String> address;
  int mobile;
  String createdAt;
  String updatedAt;
  int iV;
  String dob;
  String referral;

  User(
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
      this.address,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.dob,
      this.referral});

  User.fromJson(Map<String, dynamic> json) {
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
    address = json['address'].cast<String>();
    mobile = json['mobile'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    dob = json['dob'];
    referral = json['referral'];
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
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['dob'] = this.dob;
    data['referral'] = this.referral;
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
    sId = json['_id'];
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
    data['_id'] = this.sId;
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
    sId = json['_id'];
    itemDetail = json['itemDetail'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['itemDetail'] = this.itemDetail;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Transactions {
  String mode;
  int amount;
  String sId;
  String paymentId;
  String createdAt;
  String updatedAt;
  int iV;

  Transactions(
      {this.mode,
      this.amount,
      this.sId,
      this.paymentId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Transactions.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    amount = json['amount'];
    sId = json['_id'];
    paymentId = json['paymentId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['amount'] = this.amount;
    data['_id'] = this.sId;
    data['paymentId'] = this.paymentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class DeliveryCharge {
  String type;
  int percentage;

  DeliveryCharge({this.type, this.percentage});

  DeliveryCharge.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    percentage = json['Percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Percentage'] = this.percentage;
    return data;
  }
}

class BuySell {
  String sId;

  BuySell({this.sId});

  BuySell.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    return data;
  }
}
