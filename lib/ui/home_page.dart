import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_bfaf/model/restaurant.dart';
import 'package:submission_bfaf/style/style.dart';
import 'package:submission_bfaf/widget/custom_widget.dart';
import 'package:submission_bfaf/widget/platform_widget.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {

  static const routeName = '/home_page';
  final String title = 'COOKIEZ';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context)
    );
  }

  Widget _androidBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: accentColor
          ),
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar (
          leading: Text(
            title,
            style: cookiezTextTheme.headline3,
          ),
        ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return _buildListItem(context, restaurants[index]);
          }
        );
      }
    );
  }

  Widget _buildListItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
      },
      child: Material(
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: _buildConfigurationItem(restaurant),
        )
      ),
    );
  }

  Widget _buildConfigurationItem(Restaurant restaurant) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: ImageRestaurantListWidget(restaurant: restaurant),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding:  EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: cookiezTextTheme.bodyText1,
                ),
                SizedBox(height: 4.0),
                Text(
                  restaurant.city,
                  style: cookiezTextTheme.caption,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}