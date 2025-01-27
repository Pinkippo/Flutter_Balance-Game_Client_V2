/// 리뷰 모델
class Review {
  final int boardReviewId;
  final int boardId;
  final int userId;
  final String nickName;
  final String title;
  final String comment;
  final List<String> keywords;
  final bool isLike;
  final bool isDislike;
  final String profile;

  Review({
    required this.boardReviewId,
    required this.boardId,
    required this.userId,
    required this.nickName,
    required this.title,
    required this.comment,
    required this.keywords,
    required this.isLike,
    required this.isDislike,
    required this.profile,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      boardReviewId: json['boardReviewId'] ?? 0,
      boardId: json['boardId'] ?? 0,
      userId: json['userId'] ?? 0,
      nickName: json['nickname'] ?? '',
      title: json['title'] ?? '',
      comment: json['comment'] ?? '',
      keywords:
          (json['keywords'] as List).map((item) => item.toString()).toList(),
      isLike: json['isLike'] ?? false,
      isDislike: json['isDislike'] ?? false,
      profile: json['profile'] ?? '',
    );
  }
}
