import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pizzahut/model/Addons.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'package:flutter_config/flutter_config.dart';

class HttpServiceAddon {

  final String getUrl = "http://"+FlutterConfig.get('IP')+":8000/addon";

  Future<List<Addons>> getAddons() async {
    Response res = await get(Uri.parse(getUrl));
    if (res.statusCode == 200) {
      //log(res.body);
      List<dynamic> body = jsonDecode(res.body);

      List<Addons> addons =
          body.map((dynamic item) => Addons.fromJson(item)).toList();

      return addons;
    } else {
      debugPrint('error');
      log('cant fecth data');
      throw "cant get products";
    }
  }
}
