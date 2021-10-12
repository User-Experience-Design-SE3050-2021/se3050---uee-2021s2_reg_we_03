import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizzahut/model/Product.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'package:flutter_config/flutter_config.dart';

class UserService {
  final storage = new FlutterSecureStorage();

  //Saves the user Id to the Secure Storage.
  Future<void> rememberUser(String id) async {
    await storage.write(key: "user_id", value: id);
  }

  //retrieves the user Id from secure storage.
  Future<String> getUserId() async{
    var user_id =  await storage.read(key: "user_id").toString();
    return user_id;
  }
}
