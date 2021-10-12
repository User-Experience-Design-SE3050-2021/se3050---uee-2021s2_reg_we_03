import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:pizzahut/model/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizzahut/auth/Auth.dart';
import 'package:pizzahut/utils/connection.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  int currentIndex = 1;

  Future login() async {
    var res = await http.post(Uri.parse(Connection.baseUrl + "/user/login"),
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(
            <String, String>{'email': user.email, 'password': user.password}));
    var result = await jsonDecode(res.body);
    if (result['status'] == 200) {
      var userID = result['user']['_id'];
      print(result['user']['deliveryAddress']);
      await Auth.rememberUser(userID);
      await storage.write(
          key: "address", value: result['user']['deliveryAddress']);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "Successfilly Logged In",
        ),
      );
      Navigator.pushNamed(context, '/home');
    } else if (result['status'] == 401) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
              "Incorrect email or password. Please check your credentials and try again",
        ),
      );
    } else if (result['status'] == 404) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "User does not exist!",
        ),
      );
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Something went wrong!",
        ),
      );
    }
  }

  Future<void> rememberUser(String id) async {
    await storage.write(key: "user_id", value: id);
  }

  Future<String> getUserId() async {
    var user_id = await storage.read(key: "user_id").toString();
    return user_id;
  }

  User user = User('', '', '', '', '', []);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 180,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('assets/images/wave2.png'),
                //     fit: BoxFit.fill
                //   )
                // ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 55,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 120.0,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(25),
                                      child: TextFormField(
                                        controller: TextEditingController(
                                            text: user.email),
                                        onChanged: (value) {
                                          user.email = value;
                                        },
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Email is Required';
                                          } else if (RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)) {
                                            return null;
                                          } else {
                                            return 'Enter a valid email';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.redAccent,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(top: 15),
                                          hintText: 'Email',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(25),
                                      child: TextFormField(
                                        obscureText: true,
                                        controller: TextEditingController(
                                            text: user.password),
                                        onChanged: (value) {
                                          user.password = value;
                                        },
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Password is Required';
                                          } else if (1 == 1) {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.redAccent,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(top: 15),
                                          hintText: 'Password',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      textColor: Colors.red,
                      onPressed: () {},
                      child: Text("Forgot Password ?"),
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    ),
                    FlatButton(
                      color: Colors.red,
                      padding: const EdgeInsets.all(15.0),
                      minWidth: 200.0,
                      height: 50.0,
                      hoverColor: Colors.red,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child:
                          Text('Login', style: TextStyle(color: Colors.white)),
                      focusColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      color: Colors.red,
                      padding: const EdgeInsets.all(15.0),
                      minWidth: 200.0,
                      hoverColor: Colors.red,
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/register')},
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Icon(Icons.person, color: Colors.white),
                          Text('Become a member',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      focusColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(height: 10),
                    SignInButton(
                      Buttons.Google,
                      text: "Sign up with Google",
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
