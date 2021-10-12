import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pizzahut/api/http_service_payment.dart';
import 'package:pizzahut/api/user_services.dart';
import 'package:pizzahut/model/PaymentDetails.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    child: Center(
      child: CreditCardWidget(
          cardNumber: '4111 4582 4582 4511',
          expiryDate: '03/21',
          cardHolderName: 'Mahendra Thammita',
          cvvCode: '154',
          showBackView: false,
          obscureCardNumber: true,
          obscureCardCvv: true,
          height: 175,
          textStyle: TextStyle(color: Colors.yellowAccent),
          animationDuration: Duration(milliseconds: 1000)
      ),

    ),
  ),
))
    .toList();

class Summary extends StatefulWidget {
  Summary({Key? key}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  final storage = new FlutterSecureStorage();
  final CarouselController _controller = CarouselController();
  UserService userServices = UserService();
  HttpServicePayment servicePayment = HttpServicePayment();

  int _current = 0;
  String? _userId;

  String? _deliveryAddress;

  getDeliveryAddress() async{
    await storage.read(key: "delivery_Address").then((value) {
      setState(() {
        _deliveryAddress = value.toString();
        debugPrint("delivery_Address Is : "+ _deliveryAddress!);
      });
    });
  }

  getUserId() async{
    await storage.read(key: "user_id").then((value) {
      setState(() {
        _userId = value.toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    getDeliveryAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future: servicePayment.getPaymentDetails(_userId!),
        builder: (BuildContext context , AsyncSnapshot<PaymentDetails> snapshot){
          if(snapshot.hasData){
            return (SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
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
                            child:Center(
                              child: Text(''
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                            child:Center(
                              child: Text('Order Summary',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30.0, fontWeight: FontWeight.bold)
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Divider(
                    color: Colors.grey[200],
                    thickness: 5,
                    indent: 50.0,
                    endIndent: 50.0,
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 50, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      '1. Products',
                                      style: TextStyle(
                                        fontSize: 20.0, fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )
                                  ),
                                ]
                            ),
                          )
                      )
                    ],
                  ), //Products
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(60, 0, 50, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.task_alt,
                                    color: Colors.pink,
                                    size: 24.0,
                                  ),
                                  Text(
                                      '  You Have Selected',
                                      style: TextStyle(
                                        fontSize: 16.0, fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      )
                                  ),
                                ]
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(80, 0, 50, 0),
                            height: 80,
                            child: ListView(
                              itemExtent: 80.0,
                              scrollDirection: Axis.horizontal,
                              children:  snapshot.data!.selectedItems.map((e) => Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Image.network(e.image.toString()),
                              ),).toList()
                            ),
                          )
                      )
                    ],
                  ), //Selected Items List
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 50, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      '2. Delivery',
                                      style: TextStyle(
                                        fontSize: 20.0, fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )
                                  ),
                                ]
                            ),
                          )
                      )
                    ],
                  ), //Delivery
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(60, 0, 50, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.task_alt,
                                    color: Colors.pink,
                                    size: 24.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    width: 220,
                                    child: Expanded(
                                      child: Text(
                                          _deliveryAddress.toString(),
                                          style: TextStyle(
                                            fontSize: 16.0, fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          )
                                      ),
                                    ),
                                  ),

                                ]
                            ),
                          )
                      )
                    ],
                  ),//Address
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(60, 0, 50, 0),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                side: BorderSide(
                                    width: 2,
                                    color: Colors.red
                                ),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              onPressed: () {Navigator.pushNamed(context, '/location');},
                              child: Text(
                                  'Change Location',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red
                                  )
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 50, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      '3. Total Payment',
                                      style: TextStyle(
                                        fontSize: 20.0, fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )
                                  ),
                                ]
                            ),
                          )
                      )
                    ],
                  ),//Total Payment
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(60, 0, 50, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.task_alt,
                                    color: Colors.pink,
                                    size: 24.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    width: 220,
                                    child: Expanded(
                                      child: Text(
                                          'You Have Paid',
                                          style: TextStyle(
                                            fontSize: 16.0, fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          )
                                      ),
                                    ),
                                  ),

                                ]
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                    indent:60.0,
                    endIndent: 30.0,
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(100, 0, 50, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      'Discount',
                                      style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      )
                                  ),
                                  Text(
                                      'Rs 00.00',
                                      style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      )
                                  )
                                ]
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(100, 0, 50, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 20.0, fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )
                                  ),
                                  Text(
                                      "Rs "+(snapshot.data!.totalPrice + 150).toString()+ ".00",
                                      style: TextStyle(
                                        fontSize: 20.0, fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      )
                                  )
                                ]
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                    indent: 30.0,
                    endIndent: 30.0,
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(40, 0, 50, 0),
                            child: FlatButton(
                              color: Colors.red,
                              padding: const EdgeInsets.all(10.0),
                              hoverColor: Colors.red,
                              onPressed: () => {
                                Navigator.pushNamed(context, '/tracking')
                              },
                              child: Text('Track Order',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  )
                              ),
                              focusColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          )

                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      )

    );
  }
}
