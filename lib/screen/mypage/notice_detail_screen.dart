import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/notice/notice_controller.dart';

class NoticeDetailScreen extends GetView<NoticeController> {
  const NoticeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '공지사항 상세',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.title.value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  controller.createdAt.value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Text(
                  '조회수 ${controller.viewCount.value}회',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Divider(
              height: 2,
              color: Colors.black.withOpacity(0.1),
            ),
            const SizedBox(height: 25),
            Text(
              controller.content.value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
