// To parse this JSON data, do
//
//     final cartToContentModel = cartToContentModelFromMap(jsonString);

import 'dart:convert';

class CartToContentModel {
  CartToContentModel({
    this.cartTotal,
    this.cartContent,
    this.itemCount,
  });

  final String cartTotal;
  final List<CartContent> cartContent;
  final int itemCount;

  factory CartToContentModel.fromJson(String str) => CartToContentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartToContentModel.fromMap(Map<String, dynamic> json) => CartToContentModel(
    cartTotal: json["cart_total"],
    cartContent: List<CartContent>.from(json["cart_content"].values.map((item) => CartContent.fromMap(item))),
    itemCount: json["item_count"],
  );

  Map<String, dynamic> toMap() => {
    "cart_total": cartTotal,
    "cart_content": List<dynamic>.from(cartContent.map((x) => x.toMap())),
    "item_count": itemCount,
  };
}

class CartContent {
  CartContent({
    this.rowId,
    this.id,
    this.name,
    this.qty,
    this.price,
    this.weight,
    this.options,
    this.discount,
    this.tax,
    this.subtotal,
  });

  final String rowId;
  final int id;
  final String name;
  final String qty;
  final int price;
  final int weight;
  final Options options;
  final int discount;
  final int tax;
  final int subtotal;

  factory CartContent.fromJson(String str) => CartContent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartContent.fromMap(Map<String, dynamic> json) => CartContent(
    rowId: json["rowId"],
    id: json["id"],
    name: json["name"],
    qty: json["qty"],
    price: json["price"],
    weight: json["weight"],
    options: Options.fromMap(json["options"]),
    discount: json["discount"],
    tax: json["tax"],
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toMap() => {
    "rowId": rowId,
    "id": id,
    "name": name,
    "qty": qty,
    "price": price,
    "weight": weight,
    "options": options.toMap(),
    "discount": discount,
    "tax": tax,
    "subtotal": subtotal,
  };
}

class Options {
  Options({
    this.attributeId,
    this.variantId,
    this.image,
  });

  final dynamic attributeId;
  final String variantId;
  final List<Image> image;

  factory Options.fromJson(String str) => Options.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Options.fromMap(Map<String, dynamic> json) => Options(
    attributeId: json["attribute_id"],
    variantId: json["variant_id"],
    image: List<Image>.from(json["image"].map((x) => Image.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "attribute_id": attributeId,
    "variant_id": variantId,
    "image": List<dynamic>.from(image.map((x) => x.toMap())),
  };
}

class Image {
  Image({
    this.id,
    this.productId,
    this.productImage,
    this.createdAt,
    this.prefixUrl,
    this.updatedAt,
  });

  final int id;
  final int productId;
  final String productImage;
  final DateTime createdAt;
  final String prefixUrl;
  final DateTime updatedAt;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    id: json["id"],
    productId: json["product_id"],
    productImage: json["product_image"],
    createdAt: DateTime.parse(json["created_at"]),
    prefixUrl: json["prefix_url"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "product_image": productImage,
    "created_at": createdAt.toIso8601String(),
    "prefix_url": prefixUrl,
    "updated_at": updatedAt.toIso8601String(),
  };
}
