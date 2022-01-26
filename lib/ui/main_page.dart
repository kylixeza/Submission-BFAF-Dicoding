import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_bfaf_v2/data/db/restaurant_dao.dart';
import 'package:submission_bfaf_v2/scheduling/notification_helper.dart';
import 'package:submission_bfaf_v2/style/style.dart';
import 'package:submission_bfaf_v2/ui/detail_page.dart';
import 'package:submission_bfaf_v2/ui/home_page.dart';
import 'package:submission_bfaf_v2/ui/search_page.dart';
import 'package:submission_bfaf_v2/ui/settings_page.dart';
import 'package:submission_bfaf_v2/widget/platform_widget.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';
  final RestaurantDao dao;
  const MainPage({Key? key, required this.dao}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _widgets = [
    const HomePage(),
    const SearchPage(),
    const SettingsPage()
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isAndroid ? iconHome : cupertinoIconHome),
      label: 'Home'
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isAndroid ? iconSearchOn : cupertinoIconSearch),
      label: 'Search'
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isAndroid ? iconSetting : cupertinoIconSetting),
      label: 'Settings'
    ),
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _widgets[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        selectedLabelStyle: const TextStyle(color: primaryColor),
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems,),
      tabBuilder: (context, index) {
        return _widgets[index];
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(context, DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid(context),
      iosBuilder: _buildIos(context),
    );
  }
}