import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_bfaf_v2/data/preference/preference_helper.dart';
import 'package:submission_bfaf_v2/provider/settings_provider.dart';
import 'package:submission_bfaf_v2/scheduling/background_service.dart';
import 'package:submission_bfaf_v2/scheduling/notification_helper.dart';
import 'package:submission_bfaf_v2/style/style.dart';
import 'package:submission_bfaf_v2/ui/detail_page.dart';
import 'package:submission_bfaf_v2/ui/favorite_page.dart';
import 'package:submission_bfaf_v2/ui/main_page.dart';

import 'data/db/restaurant_dao.dart';
import 'data/db/restaurant_database.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorRestaurantDatabase.databaseBuilder('restaurant.db').build();
  final dao = database.restaurantDao;

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {

  final RestaurantDao dao;
  final String title = "COOKIEZ";

  const MyApp({Key? key, required this.dao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(
        preferenceHelper: PreferenceHelper(
          sharedPreferences: SharedPreferences.getInstance()
        )
      ),
      child: MaterialApp(
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
        initialRoute: MainPage.routeName,
        routes: {
          MainPage.routeName: (context) => MainPage(dao: dao),
          DetailPage.routeName: (context) => DetailPage(
            restaurantId: ModalRoute.of(context)?.settings.arguments as String,
            dao: dao,
          ),
          FavoritePage.routeName: (context) => FavoritePage(dao: dao),
          /*HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
            restaurantId: ModalRoute.of(context)?.settings.arguments as String,
            dao: dao,
          ),
          SearchPage.routeName: (context) => const SearchPage(),
          FavoritePage.routeName: (context) => FavoritePage(dao: dao),*/
        },
      ),
    );
  }
}
