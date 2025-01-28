import 'package:get/get.dart';
import 'package:yangjataekil/data/model/notice/notice_detail_response_model.dart';

import '../../data/model/notice/notice.dart';
import '../../data/model/notice/notice_response_model.dart';
import '../../data/repository/notice_repository.dart';

class NoticeController extends GetxController {
  // /// 공지 목록
  // final notices = <Notice>[
  //   Notice(
  //       type: SEARCHCONDITION.normal,
  //       title: '일반 공지 1',
  //       content: '내용 1',
  //       date: '2024.03.28'),
  //   Notice(
  //       type: SEARCHCONDITION.event,
  //       title: '이벤트 공지 1',
  //       content: '내용 2',
  //       date: '2024.03.28'),
  //   // 추가 공지사항을 여기에 추가
  // ].obs;

  @override
  void onInit() async {
    await getNotice();
    super.onInit();
  }

  /// 공지 타입
  final type = SEARCHCONDITION.ALL.obs;

  /// 공지 ID
  final announcementId = 0.obs;

  /// 공지 제목
  final title = ''.obs;

  /// 공지 내용
  final content = ''.obs;

  /// 공지 날짜
  final createdAt = ''.obs;

  /// 조회수
  final viewCount = 0.obs;

  /// 수정 날짜
  final updatedAt = ''.obs;

  /// 공지사항 리스트
  final RxList<Notice> notices = <Notice>[].obs;

  /// 로딩 상태
  final RxBool isLoading = false.obs;

  /// 공지사항 조회
  Future<void> getNotice() async {
    try {
      isLoading.value = true;

      NoticeResponseModel response = await NoticeRepository().getNotice('ALL');

      notices.addAll(response.notices);
    } catch (e) {
      print('공지사항 조회 실패: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// 특정 타입의 공지사항 필터링
  List<Notice> filterNotices(String noticeType) {
    if (noticeType == 'ALL') {
      return notices; // 전체 공지사항 반환
    } else if (noticeType == 'GENERAL') {
      return notices
          .where((notice) => notice.type == SEARCHCONDITION.GENERAL)
          .toList();
    } else {
      return notices
          .where((notice) => notice.type == SEARCHCONDITION.EVENT)
          .toList();
    }
  }

  /// 공지사항 상세 조회
  Future<void> getNoticeDetail(int announcementId) async {
    try {
      isLoading.value = true;

      final response = await NoticeRepository().getNoticeDetail(announcementId);

      title.value = response.title;
      content.value = response.content;
      createdAt.value = response.createdAt;
      viewCount.value = response.viewCount;
      updatedAt.value = response.updatedAt;

      createdAt.value = response.createdAt.split('T')[0];
      updatedAt.value = response.updatedAt.split('T')[0];

      print('response 값 title: ${response.title}');
      print("response title: $title");
    } catch (e) {
      print('공지사항 상세 조회 실패: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
