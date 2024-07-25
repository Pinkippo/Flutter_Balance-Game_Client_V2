class Question {
  String questionTitle;
  List<String> questionItems;

  Question(
      {required this.questionTitle, required this.questionItems});

  Map<String, dynamic> toJson() {
    return {
      'title': questionTitle,
      'items': questionItems,
    };
  }
}
