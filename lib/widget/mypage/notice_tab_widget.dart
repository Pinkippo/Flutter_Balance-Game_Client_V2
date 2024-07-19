import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/notice_controller.dart';

class NoticeAllTab extends GetView<NoticeController> {
  const NoticeAllTab({super.key, required this.noticeType});

  final NoticeType noticeType;

  @override
  Widget build(BuildContext context) {
    // Filter the notices based on the noticeType
    final filteredNotices = controller.notices.where((notice) {
      if (noticeType == NoticeType.all) return true;
      return notice.type == noticeType;
    }).toList();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredNotices.length,
        itemBuilder: (context, index) {
          final notice = filteredNotices[index];
          return GestureDetector(
            onTap: () {
              print('공지사항 상세보기');
            },
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1,
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
                          notice.type == NoticeType.normal ? '[일반] ' : '[이벤트]',
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
    );
  }
}
