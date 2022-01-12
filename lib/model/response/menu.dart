import 'package:json_annotation/json_annotation.dart';
import 'food_drink.dart';

part '../build_generate/menu.g.dart';

@JsonSerializable()
class Menu {

  late List<FoodDrink> foods;
  late List<FoodDrink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

 /* Menu.fromJson(Map<String, dynamic> json) {
    foods = <Food>[];
    json['foods'].forEach((v) {
      foods.add(new Food.fromJson(v));
    });

    drinks = <Drink>[];
    json['drinks'].forEach((v) {
      drinks.add(new Drink.fromJson(v));
    });
  }*/
}