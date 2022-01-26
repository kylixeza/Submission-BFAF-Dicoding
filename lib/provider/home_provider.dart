import 'package:flutter/material.dart';
import 'package:submission_bfaf_v2/data/api/api_service.dart';
import 'package:submission_bfaf_v2/model/response/result.dart';
import 'package:submission_bfaf_v2/util/result_state.dart';

class HomeProvider extends ChangeNotifier {
  late final ApiService apiService;

  HomeProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late ListResult? _listResult;
  late String _message;
  late ResultState _state;

  ListResult? get restaurants => _listResult;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getListRestaurants();
      if(restaurants.restaurants!.isNotEmpty) {
        _state = ResultState.Success;
        notifyListeners();
        return _listResult = restaurants;
      } else {
        _state = ResultState.Empty;
        notifyListeners();
        return _message = 'There are no restaurants';
      }
    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Something went wrong';
    }
  }
}