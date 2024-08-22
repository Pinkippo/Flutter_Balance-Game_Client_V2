
/// 게임 컨텐츠 -> 내부 결과 값
class BoardContentItem {
  final int boardContentItemId;
  final int boardContentId;
  final String item;
  final int boardResultCount;

  BoardContentItem({
    required this.boardContentItemId,
    required this.boardContentId,
    required this.item,
    required this.boardResultCount,
  });

  factory BoardContentItem.fromJson(Map<String, dynamic> json) {
    return BoardContentItem(
      boardContentItemId: json['boardContentItemId'],
      boardContentId: json['boardContentId'],
      item: json['item'],
      boardResultCount: json['boardResultCount'],
    );
  }
}

/// 게임 컨텐츠 모델
class BoardContent {
  final int boardContentId;
  final String title;
  final List<BoardContentItem> boardContentItems;

  BoardContent({
    required this.boardContentId,
    required this.title,
    required this.boardContentItems,
  });

  factory BoardContent.fromJson(Map<String, dynamic> json) {
    return BoardContent(
      boardContentId: json['boardContentId'],
      title: json['title'],
      boardContentItems: (json['boardContentItems'] as List)
          .map((item) => BoardContentItem.fromJson(item))
          .toList(),
    );
  }
}
