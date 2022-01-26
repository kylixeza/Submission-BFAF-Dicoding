import 'package:json_annotation/json_annotation.dart';
import 'package:submission_bfaf_v2/model/response/restaurant.dart';

part 'result.g.dart';

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

  Map<String, dynamic> toJson(ListResult instance) => _$ListResultToJson(instance);
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