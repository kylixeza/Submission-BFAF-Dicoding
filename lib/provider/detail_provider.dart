import 'package:flutter/material.dart';
import 'package:submission_bfaf_v2/data/api/api_service.dart';
import 'package:submission_bfaf_v2/data/db/restaurant_dao.dart';
import 'package:submission_bfaf_v2/model/entity/restaurant_entity.dart';
import 'package:submission_bfaf_v2/model/response/restaurant.dart';
import 'package:submission_bfaf_v2/util/result_state.dart';

class DetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  late final RestaurantDao dao;
  late String restaurantId;

  DetailProvider({
    required this.apiService,
    required this.dao,
    required this.restaurantId,
  }) {
    _fetchDetailRestaurant();
  }

  late Restaurant? _restaurant;
  late String _message;
  late ResultState _state;
  late bool _favorite;

  Restaurant? get restaurant => _restaurant;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {

    try {
      _state = ResultState.Loading;
      notifyListeners();

      final detailRestaurant = await apiService.getDetailRestaurant(restaurantId);
      final isRestaurantFav = await isFavorite(restaurantId);

      if(isRestaurantFav) {
        final restaurantEntity = await dao.getDetailRestaurant(restaurantId);
        final restaurantResult = Restaurant(
            id: restaurantEntity!.id,
            name: restaurantEntity.name,
            description: restaurantEntity.description,
            city: restaurantEntity.city,
            address: restaurantEntity.address,
            pictureId: restaurantEntity.pictureId,
            rating: restaurantEntity.rating,
            categories: detailRestaurant.restaurant.categories,
            menus: detailRestaurant.restaurant.menus,
            customerReviews: detailRestaurant.restaurant.customerReviews
        );
        _state = ResultState.Success;
        _restaurant = restaurantResult;
        notifyListeners();
      } else {
        if(detailRestaurant.restaurant.id.isNotEmpty) {
          _state = ResultState.Success;
          notifyListeners();
          return _restaurant = detailRestaurant.restaurant;
        } else {
          _state = ResultState.Empty;
          notifyListeners();
          return _message = 'There is no detailRestaurant';
        }
      }
    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Something went wrong';
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await dao.getDetailRestaurant(id);
    if(favoriteRestaurant != null) {
      _favorite = true;
    } else {
      _favorite = false;
    }
    notifyListeners();
    return _favorite;
  }

  void addFavorite(Restaurant restaurant) async {
    final RestaurantEntity restaurantEntity = RestaurantEntity(
        restaurant.id,
        restaurant.name,
        restaurant.description,
        restaurant.city,
        restaurant.address,
        restaurant.pictureId,
        restaurant.rating
    );

    try {
      await dao.insertFavoriteRestaurant(restaurantEntity);
      notifyListeners();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Something went wrong';
      notifyListeners();
    }
  }

  void removeFavorite(Restaurant restaurant) async {
    final RestaurantEntity restaurantEntity = RestaurantEntity(
        restaurant.id,
        restaurant.name,
        restaurant.description,
        restaurant.city,
        restaurant.address,
        restaurant.pictureId,
        restaurant.rating
    );

    try {
      await dao.deleteFavoriteRestaurant(restaurantEntity);
      notifyListeners();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Something went wrong';
      notifyListeners();
    }
  }
}