import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzahut/animations/PageBouceAnimation.dart';
import 'package:pizzahut/redux/reducers.dart';
import 'package:redux/redux.dart';

class SelectCoupon extends StatefulWidget {
  SelectCoupon({Key? key}) : super(key: key);

  @override
  _SelectCouponState createState() => _SelectCouponState();
}

class _SelectCouponState extends State<SelectCoupon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                        onTap: () => {Navigator.pushNamed(context, '/payment')},
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
                    child: Text('Coupons',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 15),
                        hintText: 'Enter Your Promo Code',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Divider(color: Colors.black38),

                SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Colors.red,
                    padding: const EdgeInsets.all(15.0),
                    hoverColor: Colors.red,
                    onPressed: () =>
                      {Navigator.pushNamed(context, '')},
                    child: Text('Apply Promos',
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
        )
    );
  }
}
