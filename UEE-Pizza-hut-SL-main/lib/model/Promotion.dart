import 'package:flutter/foundation.dart';

class Promotion {
  late final String promotionTitle;
  late final String promoCode;
  late final int discount;
  late final String imageUrl;
  late final List description;

  Promotion(
      {required this.promotionTitle,
      // required this.description,
      required this.discount,
      required this.imageUrl,
      required this.promoCode});

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
        promotionTitle: json['promotionTitle'],
        // description: json['description'],
        discount: json['discount'],
        imageUrl: json['imageUrl'],
        promoCode: json['promoCode']);
  }
}
