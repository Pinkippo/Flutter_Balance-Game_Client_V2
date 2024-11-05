import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/notice_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

import '../../data/model/notice.dart';

class NoticeAllTab extends GetView<NoticeController> {
  const NoticeAllTab({super.key, required this.noticeType});

  final String noticeType;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        // 로딩 중일 때 로딩 인디케이터 표시
        return Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ),
        );
      }

      // 필터링된 공지사항 가져오기
      final filteredNotices = controller.filterNotices(noticeType);

      if (filteredNotices.isEmpty) {
        // 공지사항이 없을 경우 빈 상태 표시
        return Container(
          color: Colors.white,
          child: const Center(
            child: Text('공지사항이 없습니다.'),
          ),
        );
      }

      // 공지사항 목록 표시
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredNotices.length,
                itemBuilder: (context, index) {
                  final notice = filteredNotices[index];
                  return GestureDetector(
                    onTap: () async {
                      // 공지사항 상세 페이지로 이동
                      print('공지사항 번호확인: ${notice.announcementId}');
                      await controller.getNoticeDetail(notice.announcementId);
                      Get.toNamed('/notice_detail');
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.2,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(15, 7, 5, 7),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  notice.type == SEARCHCONDITION.GENERAL
                                      ? '[일반]'
                                      : notice.type == SEARCHCONDITION.EVENT
                                          ? '[이벤트]'
                                          : '[전체]',
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  notice.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        subtitle: Text(notice.date),
                        trailing: const IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 18,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
