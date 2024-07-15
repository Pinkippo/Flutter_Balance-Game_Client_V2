import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/notification_controller.dart';
import 'package:yangjataekil/widget/notification/notification_btn.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
        elevation: 0,
        title: const Text('알림설정',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          '혜택 및 이벤트 알림',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    NotificationBtn(
                      title: '마케팅 정보 수신 동의',
                      isChecked: false,
                      controller: controller,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    NotificationBtn(
                      title: '문자 알림',
                      isChecked: true,
                      controller: controller,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    NotificationBtn(
                      title: '포인트 적립 알림',
                      isChecked: true,
                      controller: controller,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
