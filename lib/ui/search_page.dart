import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:submission_bfaf/data/api/api_service.dart';
import 'package:submission_bfaf/model/response/restaurant.dart';
import 'package:submission_bfaf/provider/search_provider.dart';
import 'package:submission_bfaf/style/style.dart';
import 'package:submission_bfaf/util/result_state.dart';
import 'package:submission_bfaf/widget/custom_widget.dart';
import 'package:submission_bfaf/widget/platform_widget.dart';

import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  static final routeName = "/search_page";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final api = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(apiService: api),
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
            "Search Restaurant",
          ),
        ),
        body: _buildPage(context)
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Text(
          "Search Restaurant",
        ),
      ),
      child: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<SearchProvider>(
        builder: (context, value, _) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 24
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Find your favorite restaurant or menu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (String s) {
                    setState(() {
                      query = s;
                      value.fetchAllSearchRestaurant(query);
                    });
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: _buildList(context),
                ),
              ),
            ],
          );
        }
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.Success) {
          List<Restaurant>? restaurants = value.restaurants?.restaurants;
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
                return _buildListItem(context, restaurants![index]);
              },
            )
          );
        } else if(value.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        } else if(value.state == ResultState.Empty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconSearchAgain, size: 64,),
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
                Icon(iconSearchFail, size: 64,),
                SizedBox(height: 8),
                Text(
                  value.message,
                  textAlign: TextAlign.center,
                  style: cookiezTextTheme.subtitle1,
                )
              ],
            ),
          );
        } else if (value.state == ResultState.TextFieldEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconSearchOn, size: 64,),
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