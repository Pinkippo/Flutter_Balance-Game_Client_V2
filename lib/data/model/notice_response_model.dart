import '../../controller/notice_controller.dart';

class NoticeResponseModel {
  final NoticeType noticeType;
  final String title;
  final String content;
  final String date;

  NoticeResponseModel(
      {required this.noticeType,
      required this.title,
      required this.content,
      required this.date});

  factory NoticeResponseModel.fromJson(Map<String, dynamic> json) {
    return NoticeResponseModel(
      noticeType: NoticeType.values[json['noticeType']],
      title: json['title'],
      content: json['description'],
      date: json['date'],
    );
  }
}
