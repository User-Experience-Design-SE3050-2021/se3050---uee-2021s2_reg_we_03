import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pizzahut/utils/connection.dart';
import 'package:http/http.dart' as http;
import 'package:pizzahut/model/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizzahut/auth/Auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentIndex = 2;
  final storage = new FlutterSecureStorage();

  void logout() async {
    await storage.delete(key: "user_id");
    Navigator.pushNamed(context, '/login');
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
                      body: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
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
                                        Navigator.pushNamed(context, '/home')
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
                                'My Profile',
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
                                height: height * 0.53,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    double innerHeight = constraints.maxHeight;
                                    double innerWidth = constraints.maxWidth;
                                    return Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: innerHeight * 0.75,
                                            width: innerWidth,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 80,
                                                ),
                                                Text(
                                                  Auth.user.full_name,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 37,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10.0, 0.0, 32.0, 0.0),
                                                  child: Table(
                                                    columnWidths: {
                                                      0: FlexColumnWidth(0.5)
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Icon(Icons.email,
                                                            size: 25,
                                                            color: Colors.red),
                                                        Text(Auth.user.email,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
                                                      TableRow(children: [
                                                        Text(" ",
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text(" ",
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
                                                      TableRow(children: [
                                                        Icon(Icons.phone_iphone,
                                                            size: 25,
                                                            color: Colors.red),
                                                        Text(
                                                            Auth.user
                                                                .mobile_number,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
                                                      TableRow(children: [
                                                        Text(" ",
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text(" ",
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
                                                      TableRow(children: [
                                                        Icon(Icons.home,
                                                            size: 25,
                                                            color: Colors.red),
                                                        Text(
                                                            Auth.user
                                                                .delivery_address,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
                                          top: 100,
                                          left: 260,
                                          right: 0,
                                          child: Center(
                                            child: Container(
                                              child: FlatButton(
                                                textColor: Colors.red,
                                                onPressed: () {
                                                  logout();
                                                },
                                                child: Text("Logout",
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                shape: CircleBorder(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .transparent)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 320,
                                          left: 260,
                                          right: 0,
                                          child: Center(
                                            child: Container(
                                              child: FloatingActionButton(
                                                onPressed: () => {
                                                  Navigator.pushNamed(
                                                      context, '/edit_profile')
                                                },
                                                backgroundColor: Colors.red,
                                                tooltip: 'Increment',
                                                child: Icon(Icons.edit),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'My Order History',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2.5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                        height: height * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 10,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: SingleChildScrollView(
                                          child: (Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30.0, 20.0, 30.0, 0.0),
                                            child: Table(
                                              columnWidths: {
                                                0: FlexColumnWidth(0.90)
                                              },
                                              children: [
                                                TableRow(children: [
                                                  Text('Order',
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('Total',
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('Date',
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]),
                                                TableRow(children: [
                                                  Text(' ',
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(' ',
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(' ',
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]),
                                                for (var item
                                                    in Auth.user.orders)
                                                  TableRow(children: [
                                                    Text(item['items'][0]
                                                            ['productName']
                                                        .toString()),
                                                    Text('Rs ' +
                                                        item['totalAmmount']
                                                            .toString()),
                                                    Text(item['paymentDateTime'].toString().substring(0,10)),
                                                  ]),
                                              ],
                                            ),
                                          )),
                                        )),
                                  ],
                                ),
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
          },
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
        ));
  }
}
