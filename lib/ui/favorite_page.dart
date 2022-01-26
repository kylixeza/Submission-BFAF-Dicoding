import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:submission_bfaf_v2/data/db/restaurant_dao.dart';
import 'package:submission_bfaf_v2/model/entity/restaurant_entity.dart';
import 'package:submission_bfaf_v2/provider/favorite_provider.dart';
import 'package:submission_bfaf_v2/style/style.dart';
import 'package:submission_bfaf_v2/ui/detail_page.dart';
import 'package:submission_bfaf_v2/util/result_state.dart';
import 'package:submission_bfaf_v2/widget/platform_widget.dart';


class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite_page';
  final RestaurantDao dao;

  const FavoritePage({Key? key, required this.dao}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<RestaurantEntity> restaurants = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteProvider(dao: widget.dao),
      child: PlatformWidget(
        androidBuilder: _androidBuilder(context),
        iosBuilder: _iosBuilder(context),
      ),
    );
  }

  Widget _androidBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
        ),
        backgroundColor: primaryColor,
      ),
      body: _buildListFavorite(context),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Text(
          'Favorite',
        ),
        backgroundColor: primaryColor,
      ),
      child: _buildListFavorite(context),
    );
  }

  _buildListFavorite(BuildContext context) {
    return Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.Success) {
            restaurants = provider.restaurantEntity;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8
              ),
              child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 12,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return _buildListFavoriteItem(context, restaurants[index]);
                  }
              ),
            );
          }
          else if (provider.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          else if (provider.state == ResultState.Empty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(iconEmptyFavorite, size: 64),
                  const SizedBox(height: 8),
                  Text(
                    provider.message,
                    textAlign: TextAlign.center,
                    style: cookiezTextTheme.subtitle1,
                  )
                ],
              ),
            );
          }
          else {
            return const Center();
          }
        }
    );
  }

  _buildListFavoriteItem(BuildContext context, RestaurantEntity restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant.id);
      },
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0)
                  ),
                  child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurant
                          .pictureId}"
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                defaultTargetPlatform ==
                                    TargetPlatform.android
                                    ? Icons.star
                                    : CupertinoIcons.star_circle,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                  restaurant.rating.toString()
                              )
                            ],
                          ),
                          const Icon(iconFavorite, color: primaryColor, size: 24),
                        ]
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
