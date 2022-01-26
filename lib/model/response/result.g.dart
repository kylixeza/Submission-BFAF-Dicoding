// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResult _$ListResultFromJson(Map<String, dynamic> json) => ListResult(
      error: json['error'] as bool,
      message: json['message'] as String?,
      count: json['count'] as int?,
      founded: json['founded'] as int?,
      restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListResultToJson(ListResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'count': instance.count,
      'founded': instance.founded,
      'restaurants': instance.restaurants,
    };

DetailResult _$DetailResultFromJson(Map<String, dynamic> json) => DetailResult(
      error: json['error'] as bool,
      message: json['message'] as String,
      restaurant:
          Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailResultToJson(DetailResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'restaurant': instance.restaurant,
    };
