import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pizzahut/utils/connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:pizzahut/auth/Auth.dart';

class CustomerFeedback extends StatefulWidget {
  @override
  _CustomerFeedbackState createState() => _CustomerFeedbackState();
}

class _CustomerFeedbackState extends State<CustomerFeedback> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentIndex = 1;
   static final storage = new FlutterSecureStorage();

  String order_id = "1";
  String food_feedback = '';
  String delivery_feedback = '';
  double food_rating = 1;
  double delivery_rating = 1;

  Future sendFeedback() async {
     var order_id = await Auth.getOrderId();
    var res = await http.post(
        Uri.parse(Connection.baseUrl + "/user/feedback/"+order_id),
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'food_rating': food_rating.toString(),
          'delivery_rating': delivery_rating.toString(),
          'food_feedback': food_feedback,
          'delivery_feedback': delivery_feedback
        }));
    var result = jsonDecode(res.body);
    print(result['status']);
    if (result['status'] == 201) {
    showTopSnackBar(
    context,
    CustomSnackBar.info(
      message:
          "Thanks for your feedback!",
    ),
);
      Navigator.pushNamed(context, '/home');
    } else {
     showTopSnackBar(
    context,
    CustomSnackBar.error(
      message:
          "Something went wrong!",
    ),
);
    }
  }

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
                //         fit: BoxFit.fill
                //     )
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
                    "Feedback",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
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
                                  SizedBox(height: 20),
                                  Container(
                                    child: Text(
                                      'Rate our foods',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Nisebuschgardens',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        food_rating = rating;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(10),
                                      child: TextField(
                                        controller: TextEditingController(),
                                        onChanged: (value) {
                                          delivery_feedback = value;
                                        },
                                        keyboardType: TextInputType.multiline,
                                        minLines: 4,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 35),
                                            child: Icon(
                                              Icons.insert_comment,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(top: 15),
                                          hintText: 'Your feedback',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: Text(
                                      'Rate our delivery',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Nisebuschgardens',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        delivery_rating = rating;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(10),
                                      child: TextField(
                                        controller: TextEditingController(),
                                        onChanged: (value) {
                                          food_feedback = value;
                                        },
                                        keyboardType: TextInputType.multiline,
                                        minLines: 4,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 35),
                                            child: Icon(
                                              Icons.insert_comment,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(top: 15),
                                          hintText: 'Your feedback',
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
                        sendFeedback();
                      },
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      focusColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ],
                ),
              )
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
                  color: Colors.redAccent,
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
    );
  }
}
