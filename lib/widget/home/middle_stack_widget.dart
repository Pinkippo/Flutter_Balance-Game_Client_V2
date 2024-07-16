import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 중간에 띄울 내용 (스택)
class MiddleStackContent extends StatelessWidget {
  const MiddleStackContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Get.height * 0.2, // 높이를 화면 높이의 20%로 설정
      left: 20, // 조정이 필요할 경우 이 값을 수정
      right: 20, // 조정이 필요할 경우 이 값을 수정
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/login');
        },
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              '중간에 띄울 내용',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
