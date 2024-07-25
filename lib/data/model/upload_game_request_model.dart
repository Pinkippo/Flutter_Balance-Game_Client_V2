/// 질문
class Question {
  String questionTitle;
  List<String> questionItems;

  Question({required this.questionTitle, required this.questionItems});

  Map<String, dynamic> toJson() {
    return {
      'title': questionTitle,
      'items': questionItems,
    };
  }
}

/// 게임 업로드 요청 모델
class UploadGameRequestModel {
  final String gameTitle;
  final String introduce;
  List<String> keyword;
  List<Question> boardContent;

  UploadGameRequestModel(
      {required this.gameTitle,
      required this.introduce,
      required this.keyword,
      required this.boardContent});

  Map<String, dynamic> toJson() {
    return {
      'themeId': 1,
      'title': gameTitle,
      'introduce': introduce,
      'keywords': keyword,
      'boardContents': boardContent.map((e) => e.toJson()).toList(),
    };
  }
}
