import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pizzahut/pages/Main_screen.dart';

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 6), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.red[100]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50.0),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red[100],
                        radius: 100.0,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      SizedBox(height: 15.0),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                      ),
                      SizedBox(height: 200.0),
                      Text(
                        "Pizza Hut",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: 'Radicalis',
                            // fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                      Text(
                        "SRI LANKA",
                        style: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
