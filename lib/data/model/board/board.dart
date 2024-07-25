class Board {
  final int boardId;
  final String title;
  final List<String> keywords;
  final String introduce;

  Board({
    required this.boardId,
    required this.title,
    required this.keywords,
    required this.introduce,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      boardId: json['boardId'],
      title: json['title'],
      keywords: List<String>.from(json['keywords']),
      introduce: json['introduce'],
    );
  }
}
