import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yangjataekil/controller/review_controller.dart';

import '../../controller/report_controller.dart';
import '../../theme/app_color.dart';

Widget reportDialog(BuildContext context, ReviewController reviewController) {
  return Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '리뷰 신고',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          /// 신고 사유 선택
          Obx(() {
            return DropdownButtonFormField2(
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              hint: const Text(
                '신고 사유를 선택해주세요.',
                style: TextStyle(fontSize: 14),
              ),
              items: reviewController.categories
                  .map((category) => DropdownMenuItem<REPORTCATEGORY>(
                        value: category,
                        child: Text(category.displayName),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return '신고 사유를 선택';
                }
                return null;
              },
              onChanged: (value) {
                reviewController.toggleCategory(value!);
              },
              value: reviewController.selectedCategory.value == null
                  ? null
                  : reviewController.selectedCategory.value,
              decoration: const InputDecoration(
                // 드롭다운메뉴 클릭 전 테두리 색상
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                // 드롭다운메뉴 클릭 시 테두리 색상
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2),
                ),
                hintText: '신고 사유를 선택해주세요.',
              ),
            );
          }),

          const SizedBox(height: 10),

          /// 기타 선택 시 신고 내용 입력 필드 보여주기
          Obx(() {
            if (reviewController.selectedCategory.value ==
                REPORTCATEGORY.others) {
              return TextField(
                maxLines: 5,
                maxLength: 100,
                onChanged: (value) {
                  reviewController.updateContent(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: '신고 내용을 입력해주세요.',
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink(); // 아무것도 출력하지 않음
            }
          }),

          const SizedBox(height: 30),

          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const Text(
                    '신고',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  onTap: () {
                    // 신고 사유 선택하지 않았을 때
                    if (reviewController.selectedCategory.value == null) {
                      Get.snackbar('미입력 항목', '신고 사유를 선택해주세요.',
                          backgroundColor: AppColors.primaryColor,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }
                    // 신고 사유는 '기타'로 선택,, 신고 내용은 비어 있을 때
                    else if (reviewController.selectedCategory.value ==
                        REPORTCATEGORY.others) {
                      if (reviewController.content.value == '') {
                        Get.snackbar('미입력 항목', '신고 내용을 입력해주세요.',
                            backgroundColor: AppColors.primaryColor,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM);
                        return;
                      }
                    }
                    // 신고 사유 선택 후 신고 버튼 클릭 시 한번 더 물어보기
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text('신고 확인',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          content: const Text('정말 신고하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('취소',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            TextButton(
                              // 신고하기
                              onPressed: () {
                                reviewController
                                    .reviewReport(
                                        reviewController.boardReviewId.value,
                                        reviewController.content.value)
                                    .then((value) {
                                  if (value) {
                                    Get.snackbar(
                                      '신고 완료',
                                      '신고가 정상적으로 접수되었습니다!',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  } else {
                                    Get.snackbar(
                                      '신고 실패',
                                      '신고 접수에 오류가 생겼습니다.',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                });
                                Get.back();
                                Get.back();
                              },
                              child: const Text('확인',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const VerticalDivider(
                  thickness: 1.5,
                  color: Colors.grey,
                ),
                GestureDetector(
                  child: const Text(
                    '취소',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
