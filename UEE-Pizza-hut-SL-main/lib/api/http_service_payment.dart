import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart';
import 'package:pizzahut/model/PaymentDetails.dart';

class HttpServicePayment {
  final storage = new FlutterSecureStorage();
  final String addCardUrl = "http://"+FlutterConfig.get('IP')+":8000/payment/addCard";
  final String makePaymentUrl = "http://"+FlutterConfig.get('IP')+":8000/payment/makePayment";

  Future<bool> addCard(String cardNumber , String expiryDate ,String cardHolderName ,String cvvCode ,String cardHolder) async {
    var res = await http.post(Uri.parse(addCardUrl),
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'cardNumber': cardNumber,
          'expiryDate': expiryDate,
          'cardHolderName': cardHolderName,
          'cvvCode': cvvCode,
          'cardHolder': cardHolder
        }));
    var result = jsonDecode(res.body);
    print(result['status']);
    if (result['status'] == 201) {
      Fluttertoast.showToast(
          msg: "Successfully Added the Card",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return true;
    } else {
      throw Exception('Failed');
      return false;
    }
  }

  //Gets payment details
  Future<PaymentDetails> getPaymentDetails(String userId) async {
    Response res = await get(Uri.parse("http://"+FlutterConfig.get('IP')+":8000/payment/getPaymentDetailsByUserId/"+userId));
    if (res.statusCode == 200) {
      log(res.body);
      Map<String , dynamic> body = jsonDecode(res.body);

      //PaymentDetails PaymentData = PaymentDetails.paymentDetailsFromJson(res.body);
      PaymentDetails PaymentData = PaymentDetails.fromJson(body);

      return PaymentData;
    } else {
      debugPrint('error');
      log('cant fecth data');
      throw "cant get products";
    }
  }

  Future makePayment(String cardNumber , String deliveryCost ,String discount ,String totalCost ,String userId) async {
    List<String> strlist = [];
    var res = await http.post(Uri.parse(makePaymentUrl),
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },

        body: jsonEncode(<String, String>{
          'PaymentCard': cardNumber,
          'deliveryCost': deliveryCost,
          'discount': discount,
          'totalAmmount': totalCost,
          'user': userId
        }));
    var result = jsonDecode(res.body);

    print(result['status']);
    if (result['status'] == 201) {
      await storage.write(key: "order_id", value: result['orderId']);
      // Fluttertoast.showToast(
      //     msg: "Successfully Made the payment",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.TOP_RIGHT,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      //Navigator.pushNamed(context, '/login');
    } else {
      throw Exception('Failed');
    }
  }

}
