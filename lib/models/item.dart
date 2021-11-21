class ItemList {
  String sKU;
  List<Charges> charges;
  String collections;
  List<Composition> composition;
  String createdAt;
  String description;
  String docType;
  int grossweight;
  String id;
  Item item;
  String measurements;
  Product product;
  String ringsize;
  int units;
  String updatedAt;
  int amount;
  int totalAmount;

  ItemList(
      {this.sKU,
      this.charges,
      this.collections,
      this.composition,
      this.createdAt,
      this.description,
      this.docType,
      this.grossweight,
      this.id,
      this.item,
      this.measurements,
      this.product,
      this.ringsize,
      this.units,
      this.updatedAt,
      this.amount,
      this.totalAmount});

  ItemList.fromJson(Map<String, dynamic> json) {
    sKU = json['SKU'];
    if (json['charges'] != null) {
      charges = new List<Charges>();
      json['charges'].forEach((v) {
        charges.add(new Charges.fromJson(v));
      });
    }
    collections = json['collections'];
    if (json['composition'] != null) {
      composition = new List<Composition>();
      json['composition'].forEach((v) {
        composition.add(new Composition.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    description = json['description'];
    docType = json['docType'];
    grossweight = json['grossweight'];
    id = json['id'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    measurements = json['measurements'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    ringsize = json['ringsize'];
    units = json['units'];
    updatedAt = json['updatedAt'];
    amount = json['amount'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SKU'] = this.sKU;
    if (this.charges != null) {
      data['charges'] = this.charges.map((v) => v.toJson()).toList();
    }
    data['collections'] = this.collections;
    if (this.composition != null) {
      data['composition'] = this.composition.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['docType'] = this.docType;
    data['grossweight'] = this.grossweight;
    data['id'] = this.id;
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    data['measurements'] = this.measurements;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['ringsize'] = this.ringsize;
    data['units'] = this.units;
    data['updatedAt'] = this.updatedAt;
    data['amount'] = this.amount;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}

class Charges {
  int percentage;
  String status;
  String type;
  String createdAt;
  String docType;
  String id;
  String updatedAt;

  Charges(
      {this.percentage,
      this.status,
      this.type,
      this.createdAt,
      this.docType,
      this.id,
      this.updatedAt});

  Charges.fromJson(Map<String, dynamic> json) {
    percentage = json['Percentage'];
    status = json['Status'];
    type = json['Type'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Percentage'] = this.percentage;
    data['Status'] = this.status;
    data['Type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Composition {
  Diamond diamond;
  MetalGroup metalGroup;
  int weight;

  Composition({this.diamond, this.metalGroup, this.weight});

  Composition.fromJson(Map<String, dynamic> json) {
    diamond =
        json['diamond'] != null ? new Diamond.fromJson(json['diamond']) : null;
    metalGroup = json['metalGroup'] != null
        ? new MetalGroup.fromJson(json['metalGroup'])
        : null;
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diamond != null) {
      data['diamond'] = this.diamond.toJson();
    }
    if (this.metalGroup != null) {
      data['metalGroup'] = this.metalGroup.toJson();
    }
    data['weight'] = this.weight;
    return data;
  }
}

class Diamond {
  String categoryId;
  String certifyAuthority;
  String clarity;
  String collectionId;
  String color;
  String createdAt;
  String cut;
  String docType;
  String gemstones;
  String id;
  String shape;
  String updatedAt;
  String varietyId;

  Diamond(
      {this.categoryId,
      this.certifyAuthority,
      this.clarity,
      this.collectionId,
      this.color,
      this.createdAt,
      this.cut,
      this.docType,
      this.gemstones,
      this.id,
      this.shape,
      this.updatedAt,
      this.varietyId});

  Diamond.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    certifyAuthority = json['certify_authority'];
    clarity = json['clarity'];
    collectionId = json['collection_id'];
    color = json['color'];
    createdAt = json['createdAt'];
    cut = json['cut'];
    docType = json['docType'];
    gemstones = json['gemstones'];
    id = json['id'];
    shape = json['shape'];
    updatedAt = json['updatedAt'];
    varietyId = json['variety_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['certify_authority'] = this.certifyAuthority;
    data['clarity'] = this.clarity;
    data['collection_id'] = this.collectionId;
    data['color'] = this.color;
    data['createdAt'] = this.createdAt;
    data['cut'] = this.cut;
    data['docType'] = this.docType;
    data['gemstones'] = this.gemstones;
    data['id'] = this.id;
    data['shape'] = this.shape;
    data['updatedAt'] = this.updatedAt;
    data['variety_id'] = this.varietyId;
    return data;
  }
}

class MetalGroup {
  String createdAt;
  String docType;
  double fineness;
  String id;
  String karatage;
  List<Metals> metals;
  int referenceId;
  String shortName;
  String updatedAt;

  MetalGroup(
      {this.createdAt,
      this.docType,
      this.fineness,
      this.id,
      this.karatage,
      this.metals,
      this.referenceId,
      this.shortName,
      this.updatedAt});

  MetalGroup.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    fineness = json['fineness'];
    id = json['id'];
    karatage = json['karatage'];
    if (json['metals'] != null) {
      metals = new List<Metals>();
      json['metals'].forEach((v) {
        metals.add(new Metals.fromJson(v));
      });
    }
    referenceId = json['referenceId'];
    shortName = json['shortName'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['fineness'] = this.fineness;
    data['id'] = this.id;
    data['karatage'] = this.karatage;
    if (this.metals != null) {
      data['metals'] = this.metals.map((v) => v.toJson()).toList();
    }
    data['referenceId'] = this.referenceId;
    data['shortName'] = this.shortName;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Metals {
  String createAt;
  String docType;
  String icon;
  String id;
  String name;
  String updateAt;

  Metals(
      {this.createAt,
      this.docType,
      this.icon,
      this.id,
      this.name,
      this.updateAt});

  Metals.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    docType = json['docType'];
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createAt'] = this.createAt;
    data['docType'] = this.docType;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    data['updateAt'] = this.updateAt;
    return data;
  }
}

class Item {
  String createdAt;
  String docType;
  String id;
  List<String> images;
  String name;
  String updatedAt;

  Item(
      {this.createdAt,
      this.docType,
      this.id,
      this.images,
      this.name,
      this.updatedAt});

  Item.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    images = json['images'].cast<String>();
    name = json['name'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['images'] = this.images;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Product {
  String createdAt;
  String docType;
  String id;
  List<String> images;
  String name;
  String updatedAt;
  String video;

  Product(
      {this.createdAt,
      this.docType,
      this.id,
      this.images,
      this.name,
      this.updatedAt,
      this.video});

  Product.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    images = json['images'].cast<String>();
    name = json['name'];
    updatedAt = json['updatedAt'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['images'] = this.images;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    data['video'] = this.video;
    return data;
  }
}
