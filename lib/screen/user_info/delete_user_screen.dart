import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';

import '../../theme/app_color.dart';

class DeleteUserScreen extends GetView<AuthController> {
  const DeleteUserScreen({super.key});

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
        title: const Text(
          '회원탈퇴',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          '양자택일을 탈퇴하시나요??',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      '탈퇴하시는 이유를 알려주세요.',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField2(
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      hint: const Text(
                        '탈퇴 사유를 선택해주세요.',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: controller.deleteReasons
                          .map((reason) => DropdownMenuItem(
                                value: reason,
                                child: Text(reason.name),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return '신고 사유를 선택';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.selectedDeleteReason.value = value!;
                        print('선택된 사유: $value');
                      },
                      value: null,
                      decoration: const InputDecoration(
                        // 드롭다운메뉴 클릭 전 테두리 색상
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        // 드롭다운메뉴 클릭 시 테두리 색상
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 2),
                        ),
                        hintText: '신고 사유를 선택해주세요.',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return controller.selectedDeleteReason.value ==
                              DELETEREASONS.directInput
                          ? TextFormField(
                              maxLines: 5,
                              maxLength: 100,
                              onChanged: (value) {
                                controller.changeDirectInputText(value);
                              },
                              decoration: const InputDecoration(
                                hintText: '기타 사유를 입력해주세요.',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 2),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            // 탈퇴하기 버튼 클릭 시 확인 다이얼로그
            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: const Text(
                  '회원탈퇴',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                content: const Text('정말 탈퇴하시나요?'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(105, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          controller.deleteUser();
                        },
                        child: const Text(
                          '탈퇴하기',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: const Size(105, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          overlayColor: Colors.white,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text('탈퇴하기'),
        ),
      ),
    );
  }
}
