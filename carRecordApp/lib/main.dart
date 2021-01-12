import 'package:carRecordApp/UI/filter_page_owners.dart';
import 'package:carRecordApp/UI/landing_page.dart';
import 'package:carRecordApp/UI/view_single_car_details.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:carRecordApp/UI/cars_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark));
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
      child: OwnerApp(),
    ),
  );
}

class OwnerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owners App',
      routes: {
        FilterPage.routeName: (ctx) => FilterPage(),
        Carspage.routeName: (ctx) => Carspage(),
        ViewCarOwnerDetails.routeName: (ctx) => ViewCarOwnerDetails()
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.cyan,
        fontFamily: 'Ubuntu',
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
    );
  }
}
