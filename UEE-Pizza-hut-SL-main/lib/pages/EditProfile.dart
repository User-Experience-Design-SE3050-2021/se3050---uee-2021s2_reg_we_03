import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pizzahut/utils/connection.dart';
import 'package:http/http.dart' as http;
import 'package:pizzahut/model/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizzahut/auth/Auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentIndex = 1;
  final storage = new FlutterSecureStorage();
  // User user = User('', '', '', '', '');
  String full_name = Auth.user.full_name;
  String email = Auth.user.email;
  String mobile_number = Auth.user.mobile_number;
  String delivery_address = Auth.user.delivery_address;
  String old_password = "";
  String new_password = "";

  Future update() async {
    var id = await Auth.getUserId();
    
    var res = await http.put(
        Uri.parse(Connection.baseUrl + "/user/update/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'full_name': full_name,
          'mobile_number': mobile_number,
          'delivery_address': delivery_address,
        }));
    var result = jsonDecode(res.body);
    if (result['status'] == 200) {
     showTopSnackBar(
    context,
    CustomSnackBar.success(
      message:
          "{Profile Updated}",
    ),
);
      Navigator.pushNamed(context, '/profile');
    } else
          showTopSnackBar(
    context,
    CustomSnackBar.error(
      message:
          "Something went wrong!",
    ),
);
  }

  Future updatePassword() async {
    var id = await Auth.getUserId();
    var res = await http.put(
        Uri.parse(Connection.baseUrl + "/user/update_password/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'old_password': old_password,
          'new_password': new_password
        }));
    var result = jsonDecode(res.body);
    if (result['status'] == 200) {
          showTopSnackBar(
    context,
    CustomSnackBar.success(
      message:
          "{Password Changed successfully}",
    ),
);
      Navigator.pushNamed(context, '/profile');
    } 
      else if (result['status'] == 401) {
           showTopSnackBar(
    context,
    CustomSnackBar.error(
      message:
          "Password Mismatched!",
    ),
);
    } else
           showTopSnackBar(
    context,
    CustomSnackBar.error(
      message:
          "Something went wrong!",
    ),
);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: FutureBuilder(
            future: Auth.view(),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      Scaffold(
                        backgroundColor: Colors.transparent,
                        body: SingleChildScrollView(                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 73),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        child: Image.asset(
                                          'assets/images/backButton.png',
                                          width: 1,
                                        ),
                                        onTap: () => {
                                          Navigator.pushNamed(
                                              context, '/profile')
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        child: Text(''),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Edit Profile',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 34,
                                    fontFamily: 'Nisebuschgardens',
                                  ),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                  height: height,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double innerHeight =
                                          constraints.maxHeight;
                                      double innerWidth = constraints.maxWidth;
                                      return Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                              child: Container(
                                                child: Image.asset(
                                                  'assets/images/person.png',
                                                  width: innerWidth * 0.45,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            top: 180,
                                            child: Container(
                                               child: Form(
                            key: _formKey,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Material(
                                                      elevation: 5.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: TextFormField(
                                                        controller:
                                                            TextEditingController(
                                                                text:email),
                                                        onChanged: (value) {
                                                         email = value;
                                                        },
                                                        validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Email is Required';
                                        } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                          return null;
                                        }
                                        else{
                                          return 'Enter a valid email';
                                        }
                                      },
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.email,
                                                                  color: Colors
                                                                      .redAccent,
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top:
                                                                            15),
                                                               ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Material(
                                                      elevation: 5.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: TextFormField(
                                                        controller:
                                                            TextEditingController(
                                                                text: delivery_address),
                                                        onChanged: (value) {
                                                          delivery_address =
                                                              value;
                                                        },
                                                        validator:
                                                            (String? value) {
                                                          if (value!.isEmpty) {
                                                            return 'Address is Required';
                                                          } else if (1 == 1) {
                                                            return null;
                                                          }
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          prefixIcon: Icon(
                                                            Icons.home,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Material(
                                                      elevation: 5.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: TextFormField(
                                                        controller:
                                                            TextEditingController(
                                                                text: mobile_number),
                                                        onChanged: (value) {
                                                          mobile_number =
                                                              value;
                                                        },
                                                        validator:
                                                            (String? value) {
                                                          if (value!.isEmpty) {
                                                            return 'Mobile number is Required';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          prefixIcon: Icon(
                                                            Icons.phone_android,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Material(
                                                      elevation: 5.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: TextFormField(
                                                        controller:
                                                            TextEditingController(
                                                                text: full_name),
                                                        onChanged: (value) {
                                                          full_name =
                                                              value;
                                                        },
                                                        validator:
                                                            (String? value) {
                                                          if (value!.isEmpty) {
                                                            return 'Name is Required';
                                                          } else if (1 == 1) {
                                                            return null;
                                                          }
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          prefixIcon: Icon(
                                                            Icons.person,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    child: FlatButton(
                                                      color: Colors.red,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      minWidth: 200.0,
                                                      hoverColor: Colors.red,
                                                      onPressed: () {
                                                         if(_formKey.currentState!.validate()){
                                                        update();
                                                         }
                                                      },
                                                      child: Text('Update',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      focusColor: Colors.red,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Colors.red,
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Text(
                                                    'Password reset',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'Nisebuschgardens',
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Material(
                                                      elevation: 5.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: TextFormField(
                                                        obscureText: true,
                                                        controller:
                                                            TextEditingController(),
                                                        onChanged: (value) {
                                                          old_password = value;
                                                        },
                                                    
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          prefixIcon: Icon(
                                                            Icons.lock,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          hintText:
                                                              'Old password',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Material(
                                                      elevation: 5.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: TextFormField(
                                                        obscureText: true,
                                                        controller:
                                                            TextEditingController(),
                                                        onChanged: (value) {
                                                          new_password = value;
                                                        },
                                                    
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          prefixIcon: Icon(
                                                            Icons.lock,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          hintText:
                                                              'New password',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: FlatButton(
                                                      color: Colors.red,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      minWidth: 200.0,
                                                      hoverColor: Colors.red,
                                                      onPressed: () {
                                                        updatePassword();
                                                      },
                                                      child: Text('Reset ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      focusColor: Colors.red,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Colors.red,
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                               ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottomNavigationBar: Container(
                          child: Material(
                            elevation: 15,
                            child: BottomNavigationBar(
                              currentIndex: currentIndex,
                              showSelectedLabels: false,
                              onTap: (currentIndex) => {
                                if (currentIndex == 0)
                                  {Navigator.pushNamed(context, '/home')}
                                else if (currentIndex == 1)
                                  {Navigator.pushNamed(context, '/profile')}
                                else if (currentIndex == 2)
                                  {Navigator.pushNamed(context, '/search')}
                                else if (currentIndex == 3)
                                  {Navigator.pushNamed(context, '/cart')}
                              },
                              items: [
                                BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.home,
                                     color: Colors.black38,
                                  ),

                                  title: Text(
                                    "Home",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  // backgroundColor: Colors.redAccent
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.people,
                                         color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    "Profile",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  // backgroundColor: Colors.redAccent
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.black38,
                                  ),
                                  title: Text(
                                    "Search",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  // backgroundColor: Colors.redAccent
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.black38,
                                  ),
                                  title: Text(
                                    "Cart",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  // backgroundColor: Colors.redAccent
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
