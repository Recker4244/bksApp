class SingleItemDetails {
  List<String> charges;
  String sId;
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

  SingleItemDetails(
      {this.charges,
      this.sId,
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

  SingleItemDetails.fromJson(Map<String, dynamic> json) {
    charges = json['charges'].cast<String>();
    sId = json['_id'];
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
    data['charges'] = this.charges;
    data['_id'] = this.sId;
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

class Item {
  List<String> images;
  String sId;
  String name;
  String createdAt;
  String updatedAt;
  int iV;

  Item(
      {this.images,
      this.sId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Item.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Composition {
  String sId;
  String diamond;
  String metalGroup;

  Composition({this.sId, this.diamond, this.metalGroup});

  Composition.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    diamond = json['diamond'];
    metalGroup = json['metalGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['diamond'] = this.diamond;
    data['metalGroup'] = this.metalGroup;
    return data;
  }
}

class Collections {
  List<String> images;
  String sId;
  String collectionName;
  String img1;
  String img2;
  String img3;
  String video;
  String status;

  Collections(
      {this.images,
      this.sId,
      this.collectionName,
      this.img1,
      this.img2,
      this.img3,
      this.video,
      this.status});

  Collections.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
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
    data['images'] = this.images;
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
  List<String> images;
  String sId;
  String categoryName;
  String img1;
  String img2;
  String img3;
  String video;
  String status;
  String id;

  Category(
      {this.images,
      this.sId,
      this.categoryName,
      this.img1,
      this.img2,
      this.img3,
      this.video,
      this.status,
      this.id});

  Category.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    sId = json['_id'];
    categoryName = json['category_name'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    video = json['video'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['_id'] = this.sId;
    data['category_name'] = this.categoryName;
    data['img1'] = this.img1;
    data['img2'] = this.img2;
    data['img3'] = this.img3;
    data['video'] = this.video;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}
