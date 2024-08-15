class RecommendBoardResponseModel {
  final int boardId;
  final String title;
  final String introduce;

  RecommendBoardResponseModel({
    required this.boardId,
    required this.title,
    required this.introduce,
  });

  factory RecommendBoardResponseModel.fromJson(Map<String, dynamic> json) {
    return RecommendBoardResponseModel(
      boardId: json['board']['boardId'] ?? 0,
      title: json['board']['title'] ?? 'No title',
      introduce: json['board']['introduce'] ?? 'No introduce',
    );
  }
}
