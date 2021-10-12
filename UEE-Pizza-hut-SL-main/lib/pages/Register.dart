import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:pizzahut/pages/Login.dart';
import 'package:pizzahut/model/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pizzahut/utils/connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:email_auth/email_auth.dart';
import 'package:pizzahut/auth/Auth.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final storage = new FlutterSecureStorage();

  Future save() async {
    var res = await http.post(Uri.parse(Connection.baseUrl + "/user/register"),
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'email': user.email,
          'full_name': user.full_name,
          'mobile_number': user.mobile_number,
          'delivery_address': user.delivery_address,
          'password': user.password
        }));
    var result = jsonDecode(res.body);
    print(result['status']);
    if (result['status'] == 201) {
      await storage.write(key: "email", value: user.email);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "Successfilly Registered!",
        ),
      );
      Navigator.pushNamed(context, '/verify');
      Auth.sendOTp();
    } else if (result['status'] == 401) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "User Already exist!",
        ),
      );
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Something went rong!",
        ),
      );
    }
  }

  User user = User('', '', '', '', '', []);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 180,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/images/wave2.png'),
              //         fit: BoxFit.fill)),
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
                  "Become a Member",
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
                                        if (value!.isEmpty && value == null) {
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
                                      controller: TextEditingController(
                                          text: user.delivery_address),
                                      onChanged: (value) {
                                        user.delivery_address = value;
                                      },
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Address is Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.home,
                                          color: Colors.redAccent,
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(top: 15),
                                        hintText: 'Delivey address',
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
                                      controller: TextEditingController(
                                          text: user.mobile_number),
                                      onChanged: (value) {
                                        user.mobile_number = value;
                                      },
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Mobile Number is Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.phone_android,
                                          color: Colors.redAccent,
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(top: 15),
                                        hintText: 'Mobile number',
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
                                      controller: TextEditingController(
                                          text: user.full_name),
                                      onChanged: (value) {
                                        user.full_name = value;
                                      },
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Name is Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.redAccent,
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(top: 15),
                                        hintText: 'Full name',
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
                                        } else {
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
                  SizedBox(height: 20),
                  FlatButton(
                    color: Colors.red,
                    padding: const EdgeInsets.all(20.0),
                    minWidth: 200.0,
                    hoverColor: Colors.red,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save();
                      }
                    },
                    child:
                        Text('Sign Up', style: TextStyle(color: Colors.white)),
                    focusColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.red,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    textColor: Colors.red,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("Already registered ?"),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.transparent)),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );

    throw UnimplementedError();
  }
}
