import 'Notice.dart';

class NoticeResponseModel {
  final List<Notice> notices;

  NoticeResponseModel({required this.notices});

  factory NoticeResponseModel.fromJson(Map<String, dynamic> json) {
    var noticeJson = json['announcements'] as List;
    List<Notice> noticeList =
        noticeJson.map((i) => Notice.fromJson(i)).toList();

    return NoticeResponseModel(
      notices: noticeList,
    );
  }
}
