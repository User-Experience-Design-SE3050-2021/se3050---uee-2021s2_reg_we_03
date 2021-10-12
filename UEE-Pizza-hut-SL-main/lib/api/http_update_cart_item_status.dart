import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzahut/api/user_services.dart';
import 'package:pizzahut/auth/Auth.dart';
import 'package:pizzahut/model/Addons.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:flutter_config/flutter_config.dart';

import 'package:pizzahut/model/cart_item.dart';

class HttpUpdateCartItem {
  final String getUrl = "";

  Future<String> update(bool status, String id) async {

    http.Response res = await http.post(
      Uri.parse("http://"+FlutterConfig.get('IP')+":8000/product/cart-item/" + id),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, dynamic>{
        "isSelcted": status,
      }),
    );

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Added to the Cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return "data saved";
    } else {
      Fluttertoast.showToast(
          msg: "Hmm!! Something went wrong, please try again later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return "error";
    }
  }
}
