import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:submission_bfaf_v2/data/api/api_service.dart';
import 'package:submission_bfaf_v2/model/response/restaurant.dart';
import 'package:submission_bfaf_v2/provider/home_provider.dart';
import 'package:submission_bfaf_v2/style/style.dart';
import 'package:submission_bfaf_v2/ui/favorite_page.dart';
import 'package:submission_bfaf_v2/ui/search_page.dart';
import 'package:submission_bfaf_v2/util/result_state.dart';
import 'package:submission_bfaf_v2/widget/custom_widget.dart';
import 'package:submission_bfaf_v2/widget/platform_widget.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {

  static const routeName = '/home_page';
  final String title = 'COOKIEZ';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(apiService: apiService),
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
          style: const TextStyle(
            color: accentColor
          ),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, FavoritePage.routeName);
            },
            icon: const Icon(iconFavorite),
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
          backgroundColor: primaryColor,
          trailing: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(cupertinoIconFavorite),
          ),
          transitionBetweenRoutes: true,
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
            padding: const EdgeInsets.symmetric(
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
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        } else if (value.state == ResultState.Empty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(iconSearchAgain, size: 64),
                const SizedBox(height: 8),
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
                const Icon(iconError, size: 64),
                const SizedBox(height: 8),
                Text(
                  value.message,
                  textAlign: TextAlign.center,
                  style: cookiezTextTheme.subtitle1,
                )
              ],
            ),
          );
        } else {
          return const Center(
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