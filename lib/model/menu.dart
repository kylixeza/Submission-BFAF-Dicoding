import 'drink.dart';
import 'food.dart';

class Menu {

  late List<Food> foods;
  late List<Drink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    foods = <Food>[];
    json['foods'].forEach((v) {
      foods.add(new Food.fromJson(v));
    });

    drinks = <Drink>[];
    json['drinks'].forEach((v) {
      drinks.add(new Drink.fromJson(v));
    });
  }
}