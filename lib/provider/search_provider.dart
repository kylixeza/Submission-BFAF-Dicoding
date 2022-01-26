
import 'package:flutter/material.dart';
import 'package:submission_bfaf_v2/data/api/api_service.dart';
import 'package:submission_bfaf_v2/model/response/result.dart';
import 'package:submission_bfaf_v2/util/result_state.dart';

class SearchProvider extends ChangeNotifier {
  late ApiService apiService;

  SearchProvider({required this.apiService}) {
    fetchAllSearchRestaurant(query);
  }

  late ListResult? _listResult;
  late String _message;
  late ResultState _state;
  String _query = '';

  ListResult? get restaurants => _listResult;
  String get message => _message;
  ResultState get state => _state;
  String get query => _query;

  Future<dynamic> fetchAllSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      _query = query;
      notifyListeners();
      if (_query != '') {
        final restaurants = await apiService.getListSearch(query);
        if(restaurants.restaurants!.isNotEmpty) {
          _state = ResultState.Success;
          notifyListeners();
          return _listResult = restaurants;
        } else {
          _state = ResultState.Empty;
          notifyListeners();
          return _message = 'Restaurants not found';
        }
      } else {
        _state = ResultState.TextFieldEmpty;
        notifyListeners();
        return _message =  'Find your favorite restaurant!';
      }
    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Something went wrong';
    }
  }
}