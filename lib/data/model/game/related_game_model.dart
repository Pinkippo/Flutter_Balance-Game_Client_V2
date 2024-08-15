/// 관련 게임 정보를 담는 모델
class RelatedGameModel {
  final int boardId;
  final String title;
  final String introduce;

  RelatedGameModel({
    required this.boardId,
    required this.title,
    required this.introduce,
  });

  factory RelatedGameModel.fromJson(Map<String, dynamic> json) {
    return RelatedGameModel(
      boardId: json['boardId'],
      title: json['title'],
      introduce: json['introduce'],
    );
  }
}