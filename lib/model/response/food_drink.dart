import 'package:json_annotation/json_annotation.dart';

part '../build_generate/food_drink.g.dart';

@JsonSerializable()
class FoodDrink {
  late String name;

  FoodDrink({
    required this.name
  });

  factory FoodDrink.fromJson(Map<String, dynamic> json) => _$FoodDrinkFromJson(json);
  /*Food.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }*/
}