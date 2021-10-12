import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pizzahut/model/Addons.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'package:flutter_config/flutter_config.dart';
import 'package:pizzahut/model/Cart.dart';

class HttpGetCart {
  // final String getUrl = "http://"+FlutterConfig.get('IP')+":8000/product/get-cart-items/6162ab7904e39f6e99bd92f2";

  int? val;
  int totSel = 0;

  Future<List<CartModel>> getAddons(String? userId) async {
    Response res = await get(Uri.parse("http://" +
        FlutterConfig.get('IP') +
        ":8000/product/get-cart-items/" +
        userId.toString()));

    if (res.statusCode == 200) {
      //log(res.body);
      List<dynamic> body = jsonDecode(res.body);

      List<CartModel> cart =
          body.map((dynamic item) => CartModel.fromJson(item)).toList();

      //log(cart.items.toString());

      cart.map((e) {
        if (e.isSelected) {
          totSel = totSel + 1;
        }
      });

      return cart;
    } else {
      debugPrint('error');
      log('cant fecth data');
      throw "cant get products";
    }
  }

  Future<Map<String, dynamic>> getAddDet(String? userId) async {
    Response res = await get(Uri.parse("http://" +
        FlutterConfig.get('IP') +
        ":8000/product/get-selected/" +
        userId.toString()));

    if (res.statusCode == 200) {
      log(res.body);

      Map<String, int> data = jsonDecode(res.body);

      return data;
    } else {
      debugPrint('error');
      log('cant fecth data');
      throw "cant get products";
    }
  }
}
