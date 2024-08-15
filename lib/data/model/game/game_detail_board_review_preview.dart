class BoardReviewPreview {
  final int boardReviewKeywordId;
  final int boardReviewId;
  final int userId;
  final String keyword;

  BoardReviewPreview({
    required this.boardReviewKeywordId,
    required this.boardReviewId,
    required this.userId,
    required this.keyword,
  });

  factory BoardReviewPreview.fromJson(Map<String, dynamic> json) {
    return BoardReviewPreview(
      boardReviewKeywordId: json['boardReviewKeywordId'],
      boardReviewId: json['boardReviewId'],
      userId: json['userId'],
      keyword: json['keyword'],
    );
  }
}