import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzahut/api/http_service_promotion.dart';
import 'package:pizzahut/model/Promotion.dart';

class Promotions extends StatefulWidget {
  Promotions({Key? key}) : super(key: key);

  @override
  _PromotionsState createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  final HttpServicePromotion _httpServicePromotion = new HttpServicePromotion();

  bool checkBox = false;
  int pizVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _httpServicePromotion.getPromotion(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Promotion>> snapshot) {
            if (snapshot.hasData) {
              List<Promotion>? promos = snapshot.data;
              return (Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 40.0, 20.0, 30.0),
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
                          child: Text('Promotions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 5),
                      Divider(color: Colors.black38),
                      SizedBox(height: 20.0),
                      SingleChildScrollView(
                        child: Column(
                          children: promos!.map(
                            (Promotion promo) => Column(children: [
                              GestureDetector(
                                child: promotion(promo.imageUrl),
                              )
                            ],)
                          ).toList()
                        ),
                      ),
                      // promotion('assets/images/banner01.jpg'),
                      // promotion('assets/images/banner01.jpg'),
                      // promotion('assets/images/banner01.jpg'),
                      // promotion('assets/images/banner01.jpg'),
                      // promotion('assets/images/banner01.jpg'),
                    ],
                  ),
                ),
              ));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

Widget promotion(String imagepath) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
    child: Container(
        width: double.infinity,
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(50),
          child: Image.network(imagepath),
        )),
  );
}
