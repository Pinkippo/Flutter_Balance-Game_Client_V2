/// 게임 결과 요청 모델
class GamePlayRequestModel {
  final int boardContentId;
  final int boardContentItemId;

  GamePlayRequestModel({
    required this.boardContentId,
    required this.boardContentItemId,
  });

  Map<String, dynamic> toJson() {
    return {
      'boardContentId': boardContentId,
      'boardContentItemId': boardContentItemId,
    };
  }

}