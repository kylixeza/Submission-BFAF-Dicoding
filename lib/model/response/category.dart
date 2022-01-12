import 'package:json_annotation/json_annotation.dart';

part '../build_generate/category.g.dart';

@JsonSerializable()
class Category {
  late String name;

  Category({
    required this.name
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

}