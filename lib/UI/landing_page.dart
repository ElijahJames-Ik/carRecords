import 'package:carRecordApp/Templates/card_page_template.dart';
import 'package:carRecordApp/UI/cars_page.dart';
import 'package:carRecordApp/UI/users_page.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Landing Page',
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
                  provider.isLoadingCarsPage = true;
                  Navigator.pushNamed(context, Carspage.routeName);
                },
                icon: Icons.car_rental,
              ),
              Holder(
                  cardName: 'Users Page',
                  nextPageAction: () {
                    provider.isLoadingUserPage = true;
                    Navigator.pushNamed(context, UsersPage.routeName);
                  },
                  icon: Icons.account_circle)
            ],
          ),
        ));
  }
}
