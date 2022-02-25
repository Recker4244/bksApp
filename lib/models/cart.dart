class CartItems {
  String sKU;
  Category category;
  List<Charges> charges;
  Collections collections;
  List<Composition> composition;
  String createdAt;
  String description;
  String docType;
  double grossweight;
  String id;
  Collections item;
  String measurements;
  Collections product;
  String ringsize;
  int units;
  String updatedAt;
  Collections variety;
  int amount;
  int totalAmount;
  int quantity;

  CartItems(
      {this.sKU,
      this.category,
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
      this.variety,
      this.amount,
      this.totalAmount,
      this.quantity});

  CartItems.fromJson(Map<String, dynamic> json) {
    sKU = json['SKU'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['charges'] != null) {
      charges = new List<Charges>();
      json['charges'].forEach((v) {
        charges.add(new Charges.fromJson(v));
      });
    }
    collections = json['collections'] != null
        ? new Collections.fromJson(json['collections'])
        : null;
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
    item = json['item'] != null ? new Collections.fromJson(json['item']) : null;
    measurements = json['measurements'];
    product = json['product'] != null
        ? new Collections.fromJson(json['product'])
        : null;
    ringsize = json['ringsize'];
    units = json['units'];
    updatedAt = json['updatedAt'];
    variety = json['variety'] != null
        ? new Collections.fromJson(json['variety'])
        : null;
    amount = json['amount'];
    totalAmount = json['totalAmount'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SKU'] = this.sKU;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.charges != null) {
      data['charges'] = this.charges.map((v) => v.toJson()).toList();
    }
    if (this.collections != null) {
      data['collections'] = this.collections.toJson();
    }
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
    if (this.variety != null) {
      data['variety'] = this.variety.toJson();
    }
    data['amount'] = this.amount;
    data['totalAmount'] = this.totalAmount;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Category {
  String categoryName;
  String createdAt;
  String docType;
  String id;
  List<String> images;
  String updatedAt;
  String video;

  Category(
      {this.categoryName,
      this.createdAt,
      this.docType,
      this.id,
      this.images,
      this.updatedAt,
      this.video});

  Category.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    images = json['images'].cast<String>();
    updatedAt = json['updatedAt'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['images'] = this.images;
    data['updatedAt'] = this.updatedAt;
    data['video'] = this.video;
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

  Charges({
    this.percentage,
    this.status,
    this.type,
    this.createdAt,
    this.docType,
    this.id,
    this.updatedAt,
  });

  Charges.fromJson(Map<String, dynamic> json) {
    percentage = json['Percentage'];
    status = json['Status'];
    type = json['Type'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    updatedAt = json['updatedAt'];
    status = json['status'];
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
    data['status'] = this.status;
    return data;
  }
}

class Collections {
  String createdAt;
  String docType;
  String id;
  List<String> images;
  String name;
  String updatedAt;
  String video;

  Collections(
      {this.createdAt,
      this.docType,
      this.id,
      this.images,
      this.name,
      this.updatedAt,
      this.video});

  Collections.fromJson(Map<String, dynamic> json) {
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
  String certifyAuthority;
  String clarity;
  String color;
  String createdAt;
  String cut;
  String docType;
  String gemstones;
  String id;
  String shape;
  String updatedAt;

  Diamond(
      {this.certifyAuthority,
      this.clarity,
      this.color,
      this.createdAt,
      this.cut,
      this.docType,
      this.gemstones,
      this.id,
      this.shape,
      this.updatedAt});

  Diamond.fromJson(Map<String, dynamic> json) {
    certifyAuthority = json['certify_authority'];
    clarity = json['clarity'];
    color = json['color'];
    createdAt = json['createdAt'];
    cut = json['cut'];
    docType = json['docType'];
    gemstones = json['gemstones'];
    id = json['id'];
    shape = json['shape'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['certify_authority'] = this.certifyAuthority;
    data['clarity'] = this.clarity;
    data['color'] = this.color;
    data['createdAt'] = this.createdAt;
    data['cut'] = this.cut;
    data['docType'] = this.docType;
    data['gemstones'] = this.gemstones;
    data['id'] = this.id;
    data['shape'] = this.shape;
    data['updatedAt'] = this.updatedAt;
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
  String createdAt;
  String docType;
  String icon;
  String id;
  String name;
  String updatedAt;

  Metals(
      {this.createdAt,
      this.docType,
      this.icon,
      this.id,
      this.name,
      this.updatedAt});

  Metals.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
