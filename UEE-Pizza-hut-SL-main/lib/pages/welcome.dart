import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                color: Colors.cyan,
                child: Text('Splash Screen'),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                color: Colors.cyan,
                child: Text('Login page'),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/product');
                },
                color: Colors.cyan,
                child: Text('Product page'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
