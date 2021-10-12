import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pizzahut/model/Promotion.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'package:flutter_config/flutter_config.dart';


class HttpServicePromotion {
  final String getUrl = "http://"+FlutterConfig.get('IP')+":8000/promo";

  Future<List<Promotion>> getPromotion() async {
    Response res = await get(Uri.parse(getUrl));
    if (res.statusCode == 200) {
      log(res.body);
      List<dynamic> body = jsonDecode(res.body);

      List<Promotion> promotions =
          body.map((dynamic item) => Promotion.fromJson(item)).toList();

      return promotions;
    } else {
      debugPrint('error');
      log('cant fecth data');
      throw "cant get promotions";
    }
  }
}