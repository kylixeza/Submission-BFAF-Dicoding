import 'package:flutter/cupertino.dart';
import 'package:submission_bfaf_v2/data/db/restaurant_dao.dart';
import 'package:submission_bfaf_v2/model/entity/restaurant_entity.dart';
import 'package:submission_bfaf_v2/util/result_state.dart';

class FavoriteProvider extends ChangeNotifier{
  late final RestaurantDao dao;

  FavoriteProvider({required this.dao}) {
    getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantEntity> _restaurantEntity = [];
  List<RestaurantEntity> get restaurantEntity => _restaurantEntity;

  void getFavorites() async {
    _state = ResultState.Loading;
    _restaurantEntity = await dao.getAllFavoriteRestaurants();
    if(_restaurantEntity.isNotEmpty) {
      _state = ResultState.Success;
    } else {
      _state = ResultState.Empty;
      _message = 'You have no any favorites';
    }
    notifyListeners();
  }
}