import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:submission_bfaf/data/api/api_service.dart';
import 'package:submission_bfaf/model/response/restaurant.dart';
import 'package:submission_bfaf/provider/home_provider.dart';
import 'package:submission_bfaf/style/style.dart';
import 'package:submission_bfaf/ui/search_page.dart';
import 'package:submission_bfaf/util/result_state.dart';
import 'package:submission_bfaf/widget/custom_widget.dart';
import 'package:submission_bfaf/widget/platform_widget.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {

  static const routeName = '/home_page';
  final String title = 'COOKIEZ';

  @override
  Widget build(BuildContext context) {
    final api = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(apiService: api),
      child: PlatformWidget(
          androidBuilder: _androidBuilder(context),
          iosBuilder: _iosBuilder(context)
      ),
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: _buildList(context)
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar (
          leading: Text(
            title,
            style: cookiezTextTheme.headline3,
          ),
          trailing: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: Icon(CupertinoIcons.search),
          ),
        ),
      child: _buildList(context)
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.Success) {
          final List<Restaurant>? restaurants = value.restaurants?.restaurants;
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8
            ),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 12,
              itemCount: restaurants?.length,
              itemBuilder: (context, index) {
                return _buildListItem(context, restaurants!.elementAt(index));
              },
            ),
          );
        } else if(value.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        } else if (value.state == ResultState.Empty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconSearchAgain, size: 64),
                SizedBox(height: 8),
                Text(
                  value.message,
                  textAlign: TextAlign.center,
                  style: cookiezTextTheme.subtitle1,
                )
              ],
            ),
          );
        } else if(value.state == ResultState.Error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(error, size: 64),
                SizedBox(height: 8),
                Text(
                  value.message,
                  textAlign: TextAlign.center,
                  style: cookiezTextTheme.subtitle1,
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Text(''),
          );
        }
      }
    );
  }

  Widget _buildListItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant.id);
      },
      child: ImageRestaurantListWidget(restaurant: restaurant)
    );
  }
}