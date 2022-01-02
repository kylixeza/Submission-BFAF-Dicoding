import 'dart:convert';

import 'menu.dart';

class Restaurant {

  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menu menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    pictureId = json["pictureId"];
    city = json["city"];
    rating = json["rating"].toDouble();
    menus = Menu.fromJson(json["menus"]);
  }
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }
  final Map<String, dynamic> parsed = jsonDecode(json);
  return parsed["restaurants"].map<Restaurant>((json) =>
      Restaurant.fromJson(json)).toList();
}