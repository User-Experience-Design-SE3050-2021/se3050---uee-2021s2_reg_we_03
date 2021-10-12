import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzahut/animations/PageBouceAnimation.dart';
import 'package:pizzahut/api/http_service_serch.dart';
import 'package:pizzahut/model/Product.dart';
import 'package:pizzahut/pages/product_page.dart';
import 'package:pizzahut/redux/reducers.dart';
import 'package:redux/redux.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final HttpServiceSearch _HttpServiceSearch = new HttpServiceSearch();
  int currentIndex = 2;
  bool checkBox = false;
  int pizVal = 1;

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _HttpServiceSearch.getSearchProduct(_searchString),
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                List<Product>? products = snapshot.data;
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
                                    {Navigator.pushNamed(context, '/home')},
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
                            child: Text('Search',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              onChanged: (value) {
                                this.setState(() {
                                  _searchString = value;
                                  print(value);
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.redAccent,
                                ),
                                contentPadding: EdgeInsets.only(top: 15),
                                hintText: 'Search Your Product',
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: FlatButton(
                        //     color: Colors.red,
                        //     padding: const EdgeInsets.all(15.0),
                        //     hoverColor: Colors.red,
                        //     onPressed: () {},
                        //     child: Text('Add to Cart',
                        //         style: TextStyle(color: Colors.white)),
                        //     focusColor: Colors.red,
                        //     shape: RoundedRectangleBorder(
                        //         side: BorderSide(
                        //             color: Colors.red,
                        //             width: 1,
                        //             style: BorderStyle.solid),
                        //         borderRadius: BorderRadius.circular(50)),
                        //   ),
                        // ),
                        SizedBox(height: 20.0),
                        Divider(color: Colors.black38),
                        SizedBox(height: 20.0),
                        Container(
                          child: Center(
                            child: Text('Results for : '+_searchString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20.0,)),
                          ),
                        ),
                        SizedBox(height: 15),
                        SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: products!
                                    .map(
                                      (Product product) => Column(children: [
                                        GestureDetector(
                                          onTap: () => {
                                            // Navigator.pushNamed(context, '/product')
                                            Navigator.push(
                                                context,
                                                PageBouceAnimation(
                                                    widget: Home(
                                                        product_passed:
                                                            product)))
                                          },
                                          child: Row(
                                            children: [
                                              productCard(
                                                  product.itemTitle,
                                                  product.mini_desc,
                                                  product.imageUrl,
                                                  product.price.toDouble()),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                      ]),
                                    )
                                    .toList())),
                      ],
                    ),
                  ),
                ));
              }

              return Center(child: CircularProgressIndicator());
            }),
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
                    color: Colors.redAccent,
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

Widget productCard(
    String title, String decstiption, String imagePath, double price) {
  return Expanded(
    flex: 6,
    child: FlatButton(
      onPressed: null,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: const Alignment(0.4, 1),
              child: SizedBox(
                width: 10,
                height: 10,
                child: OverflowBox(
                  minWidth: 0.0,
                  maxWidth: 120.0,
                  minHeight: 0.0,
                  maxHeight: 120.0,
                  child: Row(
                    children: [
                      Image.network(
                        imagePath,
                        width: 115,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0),
                SizedBox(
                  height: 25.0,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Text(
                        decstiption,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      )),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      ' Rs. ' + price.toString() + "0 ",
                      style: TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.black.withOpacity(1),
              width: 0.3,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(20)),
    ),
  );
}
