import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'customer_review.dart';
import 'menu.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {

  late String id;
  late String name;
  late String description;
  late String? city;
  late String? address;
  late String pictureId;
  late double rating;
  late List<Category>? categories;
  late Menu? menus;
  late List<CustomerReview>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

  Map<String, dynamic> toJson(Restaurant instance) => _$RestaurantToJson(instance);
}
