import 'package:json_annotation/json_annotation.dart';

part '../build_generate/customer_review.g.dart';

@JsonSerializable()
class CustomerReview {
  late String name;
  late String review;
  late String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => _$CustomerReviewFromJson(json);
}