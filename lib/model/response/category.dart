import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  late String name;

  Category({
    required this.name
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

}