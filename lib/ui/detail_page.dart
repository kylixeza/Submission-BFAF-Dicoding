import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_bfaf/model/drink.dart';
import 'package:submission_bfaf/model/food.dart';
import 'package:submission_bfaf/model/restaurant.dart';
import 'package:submission_bfaf/style/style.dart';

class DetailPage extends StatelessWidget {

  static const routeName = '/detail_page';
  final Restaurant restaurant;

  DetailPage({
    required this.restaurant
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildRestaurantDetail(restaurant),
              SizedBox(height: 12.0),
              Divider(
                height: 2.0,
                thickness: 1.0,
                color: primaryColor,
              ),
              SizedBox(height: 12.0),
              _buildRestaurantMenu(restaurant)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantDetail(Restaurant restaurant) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0
        ),
        child: Column(
          children: [
            Image(
              image: NetworkImage(restaurant.pictureId),
            ),
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

  Widget _buildRestaurantMenu(Restaurant restaurant) {
    final List<Drink> drinks = restaurant.menus.drinks;
    final List<Food> foods = restaurant.menus.foods;
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
            SizedBox(height: 8.0),
            Container(
              height: 200.0,
              child: ListView.builder(
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  return _buildListMenuItem(foods[index].name);
                },
              ),
            ),
            Text(
              'DRINKS',
              style: cookiezTextTheme.bodyText1,
            ),
            SizedBox(height: 8.0),
            Container(
              height: 200.0,
              child: ListView.builder(
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  return _buildListMenuItem(drinks[index].name);
                },
              ),
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
}