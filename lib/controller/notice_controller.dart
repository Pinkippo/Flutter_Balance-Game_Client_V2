import 'package:get/get.dart';

enum NoticeType {
  all,
  normal,
  event,
}

class Notice {
  final NoticeType type;
  final String title;
  final String content;
  final String date;

  Notice({
    required this.type,
    required this.title,
    required this.content,
    required this.date,
  });
}

class NoticeController extends GetxController {
  /// 공지 목록
  final notices = <Notice>[
    Notice(
        type: NoticeType.normal,
        title: '일반 공지 1',
        content: '내용 1',
        date: '2024.03.28'),
    Notice(
        type: NoticeType.event,
        title: '이벤트 공지 1',
        content: '내용 2',
        date: '2024.03.28'),
    // 추가 공지사항을 여기에 추가
  ].obs;

  /// 공지 타입
  final type = NoticeType.normal.obs;

  /// 공지 제목
  final title = '양자택일입니다요'.obs;

  /// 공지 내용
  final content = ''.obs;

  /// 공지 날짜
  final date = '2024.03.28'.obs;

  /// 리스트 개수
  final RxInt listCount = 12.obs;
}
