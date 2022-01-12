import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_bfaf/data/api/api_service.dart';
import 'package:submission_bfaf/model/response/customer_review.dart';
import 'package:submission_bfaf/model/response/food_drink.dart';
import 'package:submission_bfaf/model/response/restaurant.dart';
import 'package:submission_bfaf/provider/detail_provider.dart';
import 'package:submission_bfaf/style/style.dart';
import 'package:submission_bfaf/util/result_state.dart';
import 'package:submission_bfaf/widget/platform_widget.dart';

class DetailPage extends StatelessWidget {

  static const routeName = '/detail_page';
  final String restaurantId;
  String appBarTitle = ' ';

  DetailPage({
    required this.restaurantId
  });

  @override
  Widget build(BuildContext context) {
    final api = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return ChangeNotifierProvider(
      create: (_) => DetailProvider(apiService: api, restaurantId: restaurantId),
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _androidBuilder(context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: accentColor,
      ),
      body: _buildDetail(context),
    );
  }

  Widget _iosBuilder(context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: accentColor,
      ),
      child: _buildDetail(context),
    );
  }

  Widget _buildDetail(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (context, value, _) {
        if(value.state == ResultState.Success) {
          final Restaurant? detailRestaurant = value.detailResult!.restaurant;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: _buildRestaurantDetail(detailRestaurant),
                  ),
                  SizedBox(height: 12.0),
                  Divider(
                    height: 2.0,
                    thickness: 1.0,
                    color: primaryColor,
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    child: _buildRestaurantMenu(detailRestaurant),
                  ),
                  SizedBox(height: 12),
                  Divider(
                    height: 2.0,
                    thickness: 1.0,
                    color: primaryColor,
                  ),
                  SizedBox(height: 12),
                  Container(
                    child: _buildCustomerReview(detailRestaurant),
                  )
                ],
              ),
            ),
          );
        } else if(value.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(color: primaryColor,),
          );
        } else if(value.state == ResultState.Empty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
        } else {
          return Center(
            child: Text(''),
          );
        }
      }
    );
  }

  Widget _buildRestaurantDetail(Restaurant? restaurant) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0
        ),
        child: Column(
          children: [
            Image.network("https://restaurant-api.dicoding.dev/images/medium/${restaurant!.pictureId}"),
            SizedBox(height: 32.0),
            Text(
              restaurant.name,
              textAlign: TextAlign.start,
              style: cookiezTextTheme.headline5,
            ),
            SizedBox(height: 10.0),
            Text(
              restaurant.description,
              textAlign: TextAlign.justify,
              style: cookiezTextTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantMenu(Restaurant? restaurant) {
    final List<FoodDrink> drinks = restaurant!.menus!.drinks;
    final List<FoodDrink> foods = restaurant.menus!.foods;
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0
        ),
        child: Column(
          children: [
            Text(
              'MENU',
              style: cookiezTextTheme.headline5,
            ),
            SizedBox(height: 32.0),
            Text(
              'FOODS',
              style: cookiezTextTheme.bodyText1,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: foods.length,
              itemBuilder: (context, index) {
                return _buildListMenuItem(foods[index].name);
              },
            ),
            SizedBox(height: 24),
            Text(
              'DRINKS',
              style: cookiezTextTheme.bodyText1,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: drinks.length,
              itemBuilder: (context, index) {
                return _buildListMenuItem(drinks[index].name);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListMenuItem(String name) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: primaryColor,
        ),
        SizedBox(width: 8.0),
        Text(
          name,
          style: cookiezTextTheme.caption,
        )
      ],
    );
  }

  Widget _buildCustomerReview(Restaurant? restaurant) {
    final List<CustomerReview>? reviews = restaurant?.customerReviews;
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0
        ),
        child: Column(
          children: [
            Text(
              'Customer Review',
              style: cookiezTextTheme.headline5,
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: reviews?.length,
              itemBuilder: (context, index) {
                final CustomerReview? review = reviews?[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review!.name,
                      style: cookiezTextTheme.bodyText2?.merge(
                        TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\"${review.review}\"',
                      style: cookiezTextTheme.caption,
                    ),
                    SizedBox(height: 2),
                    Text(
                      review.date,
                      style: cookiezTextTheme.caption?.merge(
                        TextStyle(
                          fontStyle: FontStyle.italic
                        )
                      )
                    ),
                    SizedBox(height: 16)
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}