import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizzahut/api/http_get_cart_items.dart';
import 'package:pizzahut/api/http_update_cart_item_status.dart';
import 'package:pizzahut/model/Cart.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final storage = new FlutterSecureStorage();
  int currentIndex = 3;
  bool checkBox = false;
  int pizVal = 1;
  String? _userId;
  Map<String, dynamic>? totSel;

  HttpGetCart _httpGetCart = new HttpGetCart();
  HttpUpdateCartItem _httpUpdateCartItem = new HttpUpdateCartItem();

  getUserId() async {
    await storage.read(key: "user_id").then((value) {
      setState(() {
        _userId = value.toString();
        debugPrint("User Id Is : " + _userId!);
      });
    });
  }

  getAddDet() async {
    totSel = await _httpGetCart.getAddDet(getUserId());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    getAddDet();
    //totSel = _httpGetCart.getAddDet(_userId) as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _httpGetCart.getAddons(_userId),
          builder:
              (BuildContext context, AsyncSnapshot<List<CartModel>> snapshot) {
            if (snapshot.hasData) {
              List<CartModel>? dataList = snapshot.data;
              
              //int totSel = 0;

              return (Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              onTap: () =>
                                  {Navigator.pushNamed(context, '/product')},
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
                      Container(
                        child: Center(
                          child: Text('Shopping Cart',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Column(
                        
                        children: dataList!
                            .map((CartModel e) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Checkbox(
                                            value: e.isSelected,
                                            onChanged: (value) {
                                              _httpUpdateCartItem.update(
                                                  !e.isSelected, e.id);
                                              this.setState(() {
                                                checkBox = !checkBox;
                                              });
                                            },
                                            checkColor: Colors.green,
                                            activeColor: Colors.white,
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: FlatButton(
                                            onPressed: null,
                                            padding:
                                                const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Align(
                                                    alignment:
                                                        const Alignment(
                                                            0.4, 1),
                                                    child: SizedBox(
                                                      width: 10,
                                                      height: 10,
                                                      child: OverflowBox(
                                                        minWidth: 0.0,
                                                        maxWidth: 150.0,
                                                        minHeight: 0.0,
                                                        maxHeight: 150.0,
                                                        child: Row(
                                                          children: [
                                                            Image.network(
                                                              e.image,
                                                              width: 150,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        e.productName,
                                                        textAlign:
                                                            TextAlign
                                                                .left,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black),
                                                      ),
                                                      SizedBox(
                                                          height: 6.0),
                                                      Text(
                                                        "RS. " +
                                                            e.totPrice
                                                                .toString(),
                                                        textAlign:
                                                            TextAlign
                                                                .left,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                          height: 5.0),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                Text(''),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                FlatButton(
                                                              onPressed:
                                                                  () => {
                                                                this.setState(
                                                                    () {
                                                                  this.pizVal =
                                                                      this.pizVal -
                                                                          1;
                                                                }),
                                                              },
                                                              child: Image
                                                                  .asset(
                                                                      'assets/images/minus.png'),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                FlatButton(
                                                              onPressed:
                                                                  null,
                                                              child: Text(this
                                                                  .pizVal
                                                                  .toString()),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                FlatButton(
                                                              onPressed:
                                                                  () => {
                                                                this.setState(
                                                                    () {
                                                                  this.pizVal =
                                                                      this.pizVal +
                                                                          1;
                                                                }),
                                                              },
                                                              child: Image
                                                                  .asset(
                                                                      'assets/images/plus.png'),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(1),
                                                    width: 0.3,
                                                    style: BorderStyle
                                                        .solid),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40.0),
                                  ],
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 40.0),
                      Divider(
                        color: Colors.grey[200],
                        thickness: 5,
                      ),

                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              color: Colors.red,
                              padding: const EdgeInsets.all(15.0),
                              hoverColor: Colors.red,
                              onPressed: () =>
                                  {Navigator.pushNamed(context, '/location')},
                              child: Text('Checkout',
                                  style: TextStyle(color: Colors.white)),
                              focusColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
        bottomNavigationBar: Container(
          child: Material(
            elevation: 15,
            child: BottomNavigationBar(
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
              currentIndex: currentIndex,
              showSelectedLabels: false,
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
                    color: Colors.black38,
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
                    color: Colors.redAccent,
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
