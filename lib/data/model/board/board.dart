class Board {
  final int boardId;
  final String title;
  final List<String> keywords;
  final String introduce;
  final bool? isReviewExist;

  Board({
    required this.boardId,
    required this.title,
    required this.keywords,
    required this.introduce,
    this.isReviewExist,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      boardId: json['boardId'],
      title: json['title'],
      keywords: List<String>.from(json['keywords']),
      introduce: json['introduce'],
      isReviewExist: json['isReviewExist'],
    );
  }
}
