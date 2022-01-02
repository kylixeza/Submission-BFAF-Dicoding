import 'package:flutter/material.dart';
import 'package:submission_bfaf/style/style.dart';
import 'package:submission_bfaf/ui/detail_page.dart';
import 'package:submission_bfaf/ui/home_page.dart';

import 'model/restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final String title = "COOKIEZ";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: cookiezTextTheme,
        appBarTheme: AppBarTheme (
          textTheme: cookiezTextTheme,
          elevation: 0
        )
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
      },
    );
  }
}
