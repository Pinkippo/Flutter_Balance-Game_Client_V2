import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/notice_controller.dart';

class NoticeDetailScreen extends GetView<NoticeController> {
  const NoticeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Text(
              controller.createdAt.value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            Divider(
              height: 2,
              color: Colors.black.withOpacity(0.1),
            ),
            const SizedBox(height: 25),
            const Text(
              '공지사항 내용',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
