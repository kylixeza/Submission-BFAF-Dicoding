// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../response/menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    foods: (json['foods'] as List<dynamic>)
        .map((e) => FoodDrink.fromJson(e as Map<String, dynamic>))
        .toList(),
    drinks: (json['drinks'] as List<dynamic>)
        .map((e) => FoodDrink.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'foods': instance.foods,
      'drinks': instance.drinks,
    };
