import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';

/// 로그인 화면
class MyPageTap extends GetView<AuthController> {
  const MyPageTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 상단
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
        elevation: 0,
        title: const Text('마이페이지',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),

      /// 중단
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print('내 정보 수정');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '내 정보 수정 >',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 16),
                  )
                ],
              ),
            ),
            Obx(() => Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(100)),
                  child: controller.profileUrl.value.isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 100,
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                            controller.profileUrl.value,
                          ),
                        ),
                )),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  controller.nickname.value == ''
                      ? '닉네임을 설정해주세요.'
                      : controller.nickname.value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
              height: 130,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.13)),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => {
                      /// TODO : 공지사항 연결
                      Get.toNamed('/notice')
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Image.asset('assets/images/myPage/note.png'),
                          const SizedBox(
                            width: 7,
                          ),
                          const Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '공지사항',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  '>',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () => {
                      Get.toNamed('/notification'),
                      print('알림설정'),
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Image.asset('assets/images/myPage/notice.png'),
                          const SizedBox(
                            width: 7,
                          ),
                          const Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '알림설정',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  '>',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                await AuthController.to.logout().then((value) {
                  BottomNavigatorController.to.selectedIndex(1);
                  Get.toNamed('/login');
                });
              },
              child: Container(
                // color: Colors.transparent,
                height: 65,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.13)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/myPage/exit.png'),
                    const SizedBox(
                      width: 7,
                    ),
                    const Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '로그아웃',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            '>',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('버전정보 2.48.1'),
                Text(
                  '최신 버전이에요.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
