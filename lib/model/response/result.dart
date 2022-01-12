import 'package:json_annotation/json_annotation.dart';
import 'package:submission_bfaf/model/response/restaurant.dart';

part '../build_generate/result.g.dart';

@JsonSerializable()
class ListResult {
  late bool error;
  late String? message;
  late int? count;
  late int? founded;
  late List<Restaurant>? restaurants;

  ListResult({
    required this.error,
    required this.message,
    required this.count,
    required this.founded,
    required this.restaurants
  });

  factory ListResult.fromJson(Map<String, dynamic> json) => _$ListResultFromJson(json);
}

@JsonSerializable()
class DetailResult {
  late bool error;
  late String message;
  late Restaurant restaurant;

  DetailResult({
    required this.error,
    required this.message,
    required this.restaurant
  });

  factory DetailResult.fromJson(Map<String, dynamic> json) => _$DetailResultFromJson(json);
}