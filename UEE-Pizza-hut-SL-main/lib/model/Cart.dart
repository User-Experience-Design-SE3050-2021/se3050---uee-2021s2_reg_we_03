// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  CartModel({
    required this.id,
    required this.size,
    required this.crust,
    required this.additions,
    required this.count,
    required this.totPrice,
    required this.isSelected,
    required this.pizzaPrice,
    required this.image,
    required this.productName,
  });

  String id;
  String size;
  String crust;
  List<String> additions;
  int count;
  int totPrice;
  bool isSelected;
  int pizzaPrice;
  String image;
  String productName;
  int? newCount = 1;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        size: json["size"],
        crust: json["crust"],
        additions: List<String>.from(json["additions"].map((x) => x)),
        count: json["count"],
        totPrice: json["totPrice"],
        isSelected: json["isSelected"],
        pizzaPrice: json["pizzaPrice"],
        image: json["image"],
        productName: json["productName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "size": size,
        "crust": crust,
        "additions": List<dynamic>.from(additions.map((x) => x)),
        "count": count,
        "totPrice": totPrice,
        "isSelected": isSelected,
        "pizzaPrice": pizzaPrice,
        "image": image,
        "productName": productName,
      };
}
