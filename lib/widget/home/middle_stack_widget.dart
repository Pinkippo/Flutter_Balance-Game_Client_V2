import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';

/// 중간에 띄울 내용 (스택)
class MiddleStackContent extends GetView<AuthController> {
  const MiddleStackContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
        top: Get.height * 0.2, // 높이를 화면 높이의 20%로 설정
        left: 20, // 조정이 필요할 경우 이 값을 수정
        right: 20, // 조정이 필요할 경우 이 값을 수정
        child: GestureDetector(
          onTap: () {
            // 로그인이 되어있으면 my_records로 이동, 아니면 login으로 이동
            controller.accessToken.isNotEmpty
                ? Get.toNamed('/my_records')
                : Get.toNamed('/login');
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
            child: controller.accessToken.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${controller.nickname}', // 닉네임
                                style: const TextStyle(
                                  fontSize: 18, // 닉네임 글자 크기
                                  fontWeight: FontWeight.bold, // 닉네임 굵기
                                  color: Colors.black, // 닉네임 색상
                                ),
                              ),
                              const TextSpan(
                                text: ' 님, 어서오세요!', // 나머지 문장
                                style: const TextStyle(
                                  fontSize: 15, // 나머지 문장 글자 크기
                                  fontWeight: FontWeight.bold, // 나머지 문장 굵기
                                  color: Colors.black, // 나머지 문장 색상
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: '질문갯수 ', // 닉네임
                                style: TextStyle(
                                  fontSize: 15, // 닉네임 글자 크기
                                  // fontWeight: FontWeight.bold, // 닉네임 굵기
                                  color: Colors.grey, // 닉네임 색상
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${controller.userBoardCount.value}개', // 나머지 문장
                                style: const TextStyle(
                                  fontSize: 14, // 나머지 문장 글자 크기
                                  fontWeight: FontWeight.bold, // 나머지 문장 굵기
                                  color: Colors.black, // 나머지 문장 색상
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      '로그인이 필요한 서비스입니다.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
