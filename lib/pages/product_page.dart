import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Image.asset('assets/images/backButton.png')),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(''),
                  ),
                ),
                Expanded(flex: 1, child: Image.asset('assets/images/cart.png'))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Center(
                child: Container(
                  child: Image.asset('assets/images/pizza.png'),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              child: Text('Olive Mixed',
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 6.0),
            Container(
              child: Text(
                'Olive MixedLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a',
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: null,
                      child: Text('SMALL',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: null,
                      child:
                          Text('MEDIUM', style: TextStyle(color: Colors.black)),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Colors.red,
                      hoverColor: Colors.red,
                      onPressed: null,
                      child: Text('LARGE',
                          style: TextStyle(color: Colors.red[900])),
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
            SizedBox(height: 6.0),
            Container(
              child: Text('Add to Pizza',
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: cardTemplate(),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: null,
                      child:
                          Text('MEDIUM', style: TextStyle(color: Colors.black)),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Colors.red,
                      hoverColor: Colors.red,
                      onPressed: null,
                      child: Text('LARGE',
                          style: TextStyle(color: Colors.red[900])),
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
    );
  }
}
