import 'package:flutter/material.dart';
import 'package:submission_bfaf/data/api/api_service.dart';
import 'package:submission_bfaf/model/response/result.dart';
import 'package:submission_bfaf/util/result_state.dart';

class DetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  late String restaurantId;

  DetailProvider({
    required this.apiService,
    required this.restaurantId,
  }) {
    _fetchDetailRestaurant();
  }

  late DetailResult? _detailResult;
  late String _message;
  late ResultState _state;

  DetailResult? get detailResult => _detailResult;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestaurant(restaurantId);
      if(restaurant.restaurant.id.isNotEmpty) {
        _state = ResultState.Success;
        notifyListeners();
        return _detailResult = restaurant;
      } else {
        _state = ResultState.Empty;
        notifyListeners();
        return _message = 'There is no restaurant';
      }
    } catch(e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Something went wrong';
    }
  }
}