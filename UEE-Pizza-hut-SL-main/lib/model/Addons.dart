import 'package:flutter/foundation.dart';

class Addons {
  late final String id;
  late final String name;
  late final int price;
  late final String imageUrl;

  Addons(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});

  factory Addons.fromJson(Map<String, dynamic> json) {
    return Addons(
        id: json['_id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        price: json['price']);
  }
}
