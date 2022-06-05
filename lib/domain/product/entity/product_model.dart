// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.productName,
    required this.productPrice,
    required this.productDescription,
     this.id,
  });

  String productName;
  String productPrice;
  String productDescription;
  String? id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productName: json["product_name"],
        productPrice: json["product_price"],
        productDescription: json["product_description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_price": productPrice,
        "product_description": productDescription,
        "id": id,
      };
}
