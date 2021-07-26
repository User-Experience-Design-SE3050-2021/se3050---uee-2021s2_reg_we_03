import 'package:flutter/material.dart';
import 'package:pizzahut/pages/Login.dart';
import 'pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login()
    );
  }
}


