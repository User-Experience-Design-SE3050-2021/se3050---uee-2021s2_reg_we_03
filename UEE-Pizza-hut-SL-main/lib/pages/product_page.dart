import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:pizzahut/api/http_cart_item.dart';
import 'package:pizzahut/api/http_service_addon.dart';
import 'package:pizzahut/model/Addons.dart';
import 'package:pizzahut/model/Cart_Addon.dart';
import 'package:pizzahut/model/Product.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:pizzahut/model/cart_item.dart';

class Home extends StatefulWidget {
  Product product_passed;
  Home({
    Key? key,
    required this.product_passed,
  }) : super(key: key);
  //final Product product_passed = product_passed;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //callin the rest api

  final storage = new FlutterSecureStorage();

  final HttpServiceAddon _httpServiceAddon = new HttpServiceAddon();
  final HttpServiceCartItem _httpServiceCartItem = new HttpServiceCartItem();
  String? _userId;

  getUserId() async {
    await storage.read(key: "user_id").then((value) {
      setState(() {
        _userId = value.toString();
        debugPrint("User Id Is : " + _userId!);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  //sate variables

  bool _smallSize = true;
  bool _mediumSize = false;
  bool _largeSize = false;
  String _selSize = '';

  bool _panCrust = true;
  bool _stuffedCrust = false;
  bool _saussageCrust = false;
  String _selCrust = '';

  List _additions = [];
  late CartItem item;

  Widget horList(List<Addons>? addonList) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 20.0),
      //padding: const EdgeInsets.all(10.0),
      //width: 100,
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: addonList!
            .map(
              (Addons e) => Container(
                padding: const EdgeInsets.all(10),
                width: 150,
                child: Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () => Dialogs.materialDialog(
                        context: context,
                        msg:
                            'Do you want to add ${e.name} to the pizza? This will add Rs.${e.price.toDouble()} 4to the final bill.',
                        title: 'Addition!',
                        lottieBuilder: Lottie.network(
                            'https://assets3.lottiefiles.com/packages/lf20_1ybf5iqh.json',
                            fit: BoxFit.contain),
                        actions: [
                          IconsOutlineButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Cancel',
                            iconData: Icons.cancel_outlined,
                            textStyle: TextStyle(color: Colors.grey),
                            iconColor: Colors.grey,
                          ),
                          IconsButton(
                            onPressed: () => {
                              _additions.add(jsonEncode(
                                  {"name": e.name, "price": e.price})),
                              Navigator.pop(context)
                            },
                            text: 'Yes, add it!',
                            iconData: Icons.add_sharp,
                            color: Colors.red,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ]),
                    child: Column(
                      children: [
                        Image.network(e.imageUrl),
                        SizedBox(height: 8.0),
                        Text(
                          e.name,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Rs." + e.price.toString(),
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                        Image.asset('assets/images/addB.png'),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget cardTemplate() {
    return Card(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/pizza.png'),
            ),
          ),
          Text(
            'Onion',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: Text('data'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _httpServiceAddon.getAddons(),
        builder: (BuildContext context, AsyncSnapshot<List<Addons>> snapshot) {
          if (snapshot.hasData) {
            List<Addons>? addonList = snapshot.data;

            return (Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Image.asset('assets/images/backButton.png'),
                            onTap: () =>
                                {Navigator.pushNamed(context, '/home')},
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Text(''),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Image.asset('assets/images/cart.png'))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      child: Center(
                        child: Container(
                          child: Image.network(widget.product_passed.imageUrl),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      child: Text(widget.product_passed.itemTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      child: Text(
                        widget.product_passed.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text('Select Size',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              onPressed: () => {
                                this.setState(() {
                                  _smallSize = !_smallSize;
                                  _largeSize = false;
                                  _mediumSize = false;
                                  _selSize = 'small';
                                })
                              },
                              focusColor:
                                  _smallSize ? Colors.red : Colors.white,
                              color: _smallSize ? Colors.red : Colors.white,
                              child: Text('SMALL',
                                  style: TextStyle(
                                      color: _smallSize
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold)),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: _smallSize
                                          ? Colors.red
                                          : Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              onPressed: () => {
                                this.setState(() {
                                  _mediumSize = !_mediumSize;
                                  _smallSize = false;
                                  _largeSize = false;
                                  _selSize = 'medium';
                                })
                              },
                              color: _mediumSize ? Colors.red : Colors.white,
                              focusColor:
                                  _mediumSize ? Colors.red : Colors.white,
                              child: Text('MEDIUM',
                                  style: TextStyle(
                                      color: _mediumSize
                                          ? Colors.white
                                          : Colors.black)),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: _mediumSize
                                          ? Colors.red
                                          : Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              color: _largeSize ? Colors.red : Colors.white,
                              hoverColor:
                                  _largeSize ? Colors.red : Colors.white,
                              onPressed: () => {
                                this.setState(() {
                                  _largeSize = !_largeSize;
                                  _smallSize = false;
                                  _mediumSize = false;
                                  _selSize = 'large';
                                })
                              },
                              child: Text('LARGE',
                                  style: TextStyle(
                                      color: _largeSize
                                          ? Colors.white
                                          : Colors.black)),
                              focusColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: _largeSize
                                          ? Colors.red
                                          : Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        'Select Crust',
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              onPressed: () => {
                                this.setState(() {
                                  _panCrust = !_panCrust;
                                  _stuffedCrust = false;
                                  _saussageCrust = false;
                                  _selCrust = 'pan';
                                })
                              },
                              child: Column(
                                children: [
                                  Image.asset('assets/images/pan.png'),
                                  Text(
                                    'Pan',
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color:
                                          _panCrust ? Colors.red : Colors.black,
                                      width: _panCrust ? 3 : 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(10),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              onPressed: () => {
                                this.setState(() {
                                  _panCrust = false;
                                  _stuffedCrust = !_stuffedCrust;
                                  _saussageCrust = false;
                                  _selCrust = 'stuffed';
                                })
                              },
                              child: Column(
                                children: [
                                  Image.asset('assets/images/stuff.png'),
                                  Text(
                                    'Stuffed',
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: _stuffedCrust
                                          ? Colors.red
                                          : Colors.black,
                                      width: _stuffedCrust ? 3 : 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(10),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              onPressed: () => {
                                this.setState(() {
                                  _panCrust = false;
                                  _stuffedCrust = false;
                                  _saussageCrust = !_saussageCrust;
                                  _selCrust = 'saussage';
                                })
                              },
                              child: Column(
                                children: [
                                  Image.asset('assets/images/saus.png'),
                                  Text(
                                    'Saussage',
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: _saussageCrust
                                          ? Colors.red
                                          : Colors.black,
                                      width: _saussageCrust ? 3 : 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      child: Text('Add to Pizza',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 6.0),
                    Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: horList(addonList)),
                    SizedBox(height: 6.0),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              color: Colors.red,
                              padding: const EdgeInsets.all(15.0),
                              hoverColor: Colors.red,
                              onPressed: () {
                                item = new CartItem(
                                    productName:
                                        widget.product_passed.itemTitle,
                                    imageUri: widget.product_passed.imageUrl,
                                    checked: false,
                                    crust: this._selCrust,
                                    userId: _userId.toString(),
                                    size: this._selSize,
                                    additions: this._additions,
                                    
                                    pizzaPrize:
                                        widget.product_passed.price.toDouble());

                                _httpServiceCartItem.createCartItem(item);

                                //Navigator.pushNamed(context, '/cart')
                              },
                              child: Text('Add to Cart',
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
                    ),
                  ],
                ),
              ),
            ));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
