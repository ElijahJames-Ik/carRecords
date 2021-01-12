import 'package:carRecordApp/Templates/card_page_template.dart';
import 'package:carRecordApp/UI/cars_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Speedy',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.cyan[400],
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: dimension.width * 0.04,
            right: dimension.width * 0.04,
            top: dimension.height * 0.02,
          ),
          child: Column(
            children: [
              Holder(
                cardName: 'Cars Page',
                nextPageAction: () {
                  Navigator.pushNamed(context, Carspage.routeName);
                },
              ),
              Holder(
                cardName: 'Users Page',
                nextPageAction: () {},
              )
            ],
          ),
        ));
  }
}
