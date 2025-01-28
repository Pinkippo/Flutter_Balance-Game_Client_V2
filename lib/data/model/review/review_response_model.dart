import 'package:yangjataekil/data/model/review/review.dart';

/// 리뷰 리스트 응답 모델
class ReviewResponseModel {
  final List<Review> reviews;

  ReviewResponseModel({required this.reviews});

  factory ReviewResponseModel.fromJson(Map<String, dynamic> json) {
    var reviewJson = json['reviews'] as List;
    List<Review> reviewList = reviewJson.map((i) => Review.fromJson(i)).toList();

    return ReviewResponseModel(
      reviews: reviewList,
    );
  }
}