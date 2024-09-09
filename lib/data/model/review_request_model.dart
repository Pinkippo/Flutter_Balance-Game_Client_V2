class ReviewRequestModel {
  final String title;
  final String comment;
  final List<String> keywords;
  final bool isLike;
  final bool isDislike;

  ReviewRequestModel({
    required this.title,
    required this.comment,
    required this.keywords,
    required this.isLike,
    required this.isDislike,
  });

  factory ReviewRequestModel.fromJson(Map<String, dynamic> json) {
    return ReviewRequestModel(
      title: json['title'],
      comment: json['comment'],
      keywords: List<String>.from(json['keywords']),
      isLike: json['isLike'],
      isDislike: json['isDislike'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'comment': comment,
      'keywords': keywords,
      'isLike': isLike,
      'isDislike': isDislike,
    };
  }
}