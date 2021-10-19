class CartItems {
  ItemDetail itemDetail;
  int quantity;
  num amount;
  double totalAmount;

  CartItems({this.itemDetail, this.quantity, this.amount, this.totalAmount});

  CartItems.fromJson(Map<String, dynamic> json) {
    itemDetail = json['itemDetail'] != null
        ? new ItemDetail.fromJson(json['itemDetail'])
        : null;
    quantity = json['quantity'];
    amount = json['amount'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemDetail != null) {
      data['itemDetail'] = this.itemDetail.toJson();
    }
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}

class ItemDetail {
  String sId;
  List<Charges> charges;
  Item item;
  List<Composition> composition;
  Collections collections;
  Category category;
  String variety;
  Item product;
  int grossweight;
  String description;
  String sKU;
  int units;
  String ringsize;
  String measurements;
  int iV;
  String createdAt;
  String updatedAt;

  ItemDetail(
      {this.sId,
      this.charges,
      this.item,
      this.composition,
      this.collections,
      this.category,
      this.variety,
      this.product,
      this.grossweight,
      this.description,
      this.sKU,
      this.units,
      this.ringsize,
      this.measurements,
      this.iV,
      this.createdAt,
      this.updatedAt});

  ItemDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['charges'] != null) {
      charges = new List<Charges>();
      json['charges'].forEach((v) {
        charges.add(new Charges.fromJson(v));
      });
    }
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    if (json['composition'] != null) {
      composition = new List<Composition>();
      json['composition'].forEach((v) {
        composition.add(new Composition.fromJson(v));
      });
    }
    collections = json['collections'] != null
        ? new Collections.fromJson(json['collections'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    variety = json['variety'];
    product =
        json['product'] != null ? new Item.fromJson(json['product']) : null;
    grossweight = json['grossweight'];
    description = json['description'];
    sKU = json['SKU'];
    units = json['units'];
    ringsize = json['ringsize'];
    measurements = json['measurements'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.charges != null) {
      data['charges'] = this.charges.map((v) => v.toJson()).toList();
    }
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    if (this.composition != null) {
      data['composition'] = this.composition.map((v) => v.toJson()).toList();
    }
    if (this.collections != null) {
      data['collections'] = this.collections.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['variety'] = this.variety;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['grossweight'] = this.grossweight;
    data['description'] = this.description;
    data['SKU'] = this.sKU;
    data['units'] = this.units;
    data['ringsize'] = this.ringsize;
    data['measurements'] = this.measurements;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Charges {
  String sId;
  String status;
  String type;
  int percentage;
  String createdAt;
  String updatedAt;
  int iV;

  String createdDate;
  String modifiedDate;

  Charges(
      {this.sId,
      this.status,
      this.type,
      this.percentage,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.createdDate,
      this.modifiedDate});

  Charges.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    type = json['Type'];
    percentage = json['Percentage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    status = json['Status'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['Type'] = this.type;
    data['Percentage'] = this.percentage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['Status'] = this.status;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedDate'] = this.modifiedDate;
    return data;
  }
}

class Item {
  String sId;
  List<String> images;
  String name;
  String createdAt;
  String updatedAt;
  int iV;

  Item(
      {this.sId,
      this.images,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Item.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    images = json['images'].cast<String>();
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['images'] = this.images;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Composition {
  String sId;
  double weight;
  String diamond;
  MetalGroup metalGroup;

  Composition({this.sId, this.weight, this.diamond, this.metalGroup});

  Composition.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    weight = json['weight'];
    diamond = json['diamond'];
    metalGroup = json['metalGroup'] != null
        ? new MetalGroup.fromJson(json['metalGroup'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['weight'] = this.weight;
    data['diamond'] = this.diamond;
    if (this.metalGroup != null) {
      data['metalGroup'] = this.metalGroup.toJson();
    }
    return data;
  }
}

class MetalGroup {
  List<String> metals;
  String status;
  String sId;
  String karatage;
  double fineness;
  int referenceId;
  String shortName;
  String createdAt;
  String updatedAt;
  int iV;

  MetalGroup(
      {this.metals,
      this.status,
      this.sId,
      this.karatage,
      this.fineness,
      this.referenceId,
      this.shortName,
      this.createdAt,
      this.updatedAt,
      this.iV});

  MetalGroup.fromJson(Map<String, dynamic> json) {
    metals = json['metals'].cast<String>();
    status = json['status'];
    sId = json['_id'];
    karatage = json['karatage'];
    fineness = json['fineness'];
    referenceId = json['referenceId'];
    shortName = json['shortName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metals'] = this.metals;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['karatage'] = this.karatage;
    data['fineness'] = this.fineness;
    data['referenceId'] = this.referenceId;
    data['shortName'] = this.shortName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Collections {
  String sId;
  String collectionName;
  String img1;
  String img2;
  String img3;
  String video;
  String status;

  Collections(
      {this.sId,
      this.collectionName,
      this.img1,
      this.img2,
      this.img3,
      this.video,
      this.status});

  Collections.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collectionName = json['collection_name'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    video = json['video'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collection_name'] = this.collectionName;
    data['img1'] = this.img1;
    data['img2'] = this.img2;
    data['img3'] = this.img3;
    data['video'] = this.video;
    data['status'] = this.status;
    return data;
  }
}

class Category {
  String sId;
  String categoryName;
  String img1;
  String img2;
  String img3;
  String video;
  String status;

  Category(
      {this.sId,
      this.categoryName,
      this.img1,
      this.img2,
      this.img3,
      this.video,
      this.status});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['category_name'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    video = json['video'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category_name'] = this.categoryName;
    data['img1'] = this.img1;
    data['img2'] = this.img2;
    data['img3'] = this.img3;
    data['video'] = this.video;
    data['status'] = this.status;
    return data;
  }
}
