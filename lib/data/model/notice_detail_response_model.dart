class NoticeDetailResponseModel {
  final int? announcementId;
  final String type;
  final String title;
  final String content;
  final int viewCount;
  final String createdAt;
  final String updatedAt;

  NoticeDetailResponseModel({
    required this.announcementId,
    required this.type,
    required this.title,
    required this.content,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoticeDetailResponseModel.fromJson(Map<String, dynamic> json) {
    final announcement = json['announcement'] ?? {};

    return NoticeDetailResponseModel(
      announcementId: announcement['announcementId'] ?? 0, // Default value or make it nullable
      type: announcement['type'] ?? 'UNKNOWN',
      title: announcement['title'] ?? 'No Title',
      content: announcement['content'] ?? 'No Content',
      viewCount: announcement['viewCount'] ?? 0,
      createdAt: announcement['createdAt'] ?? '',
      updatedAt: announcement['updatedAt'] ?? '',
    );
  }
}
