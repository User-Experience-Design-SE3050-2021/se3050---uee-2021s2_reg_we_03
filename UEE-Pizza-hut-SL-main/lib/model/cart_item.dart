import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  String productName;
  bool checked;
  String imageUri;
  String size = '';
  String crust = '';
  double pizzaPrize;
  List additions = [];
  String userId;

  CartItem(
      {required this.productName,
      required this.imageUri,
      required this.checked,
      required this.pizzaPrize,
      required this.crust,
      required this.size,
      required this.additions,
      required this.userId});

  @override
  String toString() {
    // TODO: implement toString
    return "$productName : $checked";
  }
}
