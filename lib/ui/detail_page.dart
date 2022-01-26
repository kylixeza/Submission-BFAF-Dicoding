import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_bfaf_v2/data/api/api_service.dart';
import 'package:submission_bfaf_v2/data/db/restaurant_dao.dart';
import 'package:submission_bfaf_v2/model/response/customer_review.dart';
import 'package:submission_bfaf_v2/model/response/food_drink.dart';
import 'package:submission_bfaf_v2/model/response/restaurant.dart';
import 'package:submission_bfaf_v2/provider/detail_provider.dart';
import 'package:submission_bfaf_v2/provider/favorite_provider.dart';
import 'package:submission_bfaf_v2/style/style.dart';
import 'package:submission_bfaf_v2/util/result_state.dart';
import 'package:submission_bfaf_v2/widget/platform_widget.dart';

class DetailPage extends StatelessWidget {

  static const routeName = '/detail_page';
  final String restaurantId;
  final RestaurantDao dao;

  const DetailPage({Key? key,
    required this.restaurantId,
    required this.dao
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_) => DetailProvider(apiService: api, restaurantId: restaurantId, dao: dao),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(dao: dao),
        )
      ],
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _androidBuilder(context) {
    return Consumer<DetailProvider>(
      builder: (context, detailProvider, child) {
        return FutureBuilder<bool>(
          future: detailProvider.isFavorite(restaurantId),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return Scaffold(
              appBar: AppBar(
                  foregroundColor: accentColor,
                  title: (detailProvider.state == ResultState.Success) ?
                  Text(detailProvider.restaurant!.name) : const Text(''),
                  backgroundColor: primaryColor,
              ),
              floatingActionButton: (detailProvider.state == ResultState.Success) ?
                Consumer<FavoriteProvider>(
                  builder: (context, favProvider, child) {
                    return FloatingActionButton(
                      child: (isFavorite) ?
                      const Icon(Icons.favorite, color: accentColor,)
                          : const Icon(Icons.favorite_border, color: accentColor),
                      backgroundColor: primaryColor,
                      onPressed: () {
                        final restaurant = detailProvider.restaurant;
                        if(isFavorite) {
                          detailProvider.removeFavorite(restaurant!);
                          favProvider.getFavorites();
                        } else {
                          detailProvider.addFavorite(restaurant!);
                          favProvider.getFavorites();
                        }
                      },
                    );
                  }
                ) : const Text(''),
              body: _buildDetail(context),
            );
          },
        );
      }
    );
  }

  Widget _iosBuilder(context) {
    return Consumer<DetailProvider>(
      builder: (context, detailProvider, child) {
        return FutureBuilder<bool>(
          future: detailProvider.isFavorite(restaurantId),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: primaryColor,
                leading: (detailProvider.state == ResultState.Success) ?
                  Text(detailProvider.restaurant!.name) : const Text(''),
              ),
              child: Scaffold(
                floatingActionButton: (detailProvider.state == ResultState.Success) ?
                Consumer<FavoriteProvider>(
                    builder: (context, favProvider, child) {
                      return FloatingActionButton(
                        child: (isFavorite) ?
                        const Icon(cupertinoIconFavorite, color: accentColor,)
                            : const Icon(cupertinoIconNotFavorite, color: accentColor),
                        backgroundColor: primaryColor,
                        onPressed: () {
                          final restaurant = detailProvider.restaurant;
                          if(isFavorite) {
                            detailProvider.removeFavorite(restaurant!);
                            favProvider.getFavorites();
                          } else {
                            detailProvider.addFavorite(restaurant!);
                            favProvider.getFavorites();
                          }
                        },
                      );
                    }
                ) : const Text(''),
                body: _buildDetail(context),
              ),
            );
          }
        );
      }
    );
  }

  Widget _buildDetail(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (context, provider, _) {
        if(provider.state == ResultState.Success) {
          final Restaurant? detailRestaurant = provider.restaurant;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: _buildRestaurantDetail(detailRestaurant),
                  ),
                  const SizedBox(height: 12.0),
                  const Divider(
                    height: 2.0,
                    thickness: 1.0,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    child: _buildRestaurantMenu(detailRestaurant),
                  ),
                  const SizedBox(height: 12),
                  const Divider(
                    height: 2.0,
                    thickness: 1.0,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    child: _buildCustomerReview(detailRestaurant),
                  )
                ],
              ),
            ),
          );
        } else if(provider.state == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor,),
          );
        } else if(provider.state == ResultState.Empty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(iconSearchAgain, size: 64,),
                const SizedBox(height: 8),
                Text(
                  provider.message,
                  textAlign: TextAlign.center,
                  style: cookiezTextTheme.subtitle1,
                )
              ],
            ),
          );
        } else if(provider.state == ResultState.Error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(iconSearchFail, size: 64,),
                const SizedBox(height: 8),
                Text(
                  provider.message,
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

  Widget _buildRestaurantDetail(Restaurant? restaurant) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0
        ),
        child: Column(
          children: [
            Image.network("https://restaurant-api.dicoding.dev/images/medium/${restaurant!.pictureId}"),
            const SizedBox(height: 32.0),
            Text(
              restaurant.name,
              textAlign: TextAlign.start,
              style: cookiezTextTheme.headline5,
            ),
            const SizedBox(height: 10.0),
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
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0
        ),
        child: Column(
          children: [
            Text(
              'MENU',
              style: cookiezTextTheme.headline5,
            ),
            const SizedBox(height: 32.0),
            Text(
              'FOODS',
              style: cookiezTextTheme.bodyText1,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foods.length,
              itemBuilder: (context, index) {
                return _buildListMenuItem(foods[index].name);
              },
            ),
            const SizedBox(height: 24),
            Text(
              'DRINKS',
              style: cookiezTextTheme.bodyText1,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
        const Icon(
          Icons.circle,
          color: primaryColor,
        ),
        const SizedBox(width: 8.0),
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
        padding: const EdgeInsets.symmetric(
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews?.length,
              itemBuilder: (context, index) {
                final CustomerReview? review = reviews?[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review!.name,
                      style: cookiezTextTheme.bodyText2?.merge(
                        const TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '"${review.review}"',
                      style: cookiezTextTheme.caption,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review.date,
                      style: cookiezTextTheme.caption?.merge(
                        const TextStyle(
                          fontStyle: FontStyle.italic
                        )
                      )
                    ),
                    const SizedBox(height: 16)
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