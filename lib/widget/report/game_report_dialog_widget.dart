import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/list/all_list_controller.dart';
import 'package:yangjataekil/controller/review/review_controller.dart';
import 'package:yangjataekil/mixin/ReportMixin.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/dialog/check_dialog_widget.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

Widget reportGameDialog(boardId, ReportMixin controller) {
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
            '게임 신고',
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
              items: controller.categories
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
                controller.toggleCategory(value!);
              },
              value: controller.selectedCategory.value,
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
            if (controller.selectedCategory.value == REPORTCATEGORY.others) {
              return TextField(
                maxLines: 5,
                maxLength: 100,
                onChanged: (value) {
                  controller.updateContent(value);
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
                    if (controller.selectedCategory.value == null) {
                      CustomSnackBar.showErrorSnackBar(
                        title: '미입력 항목',
                        message: '신고 사유를 선택해주세요.',
                      );
                      return;
                    }
                    // 신고 사유는 '기타'로 선택,, 신고 내용은 비어 있을 때
                    else if (controller.selectedCategory.value ==
                        REPORTCATEGORY.others) {
                      if (controller.reportReason.value == '') {
                        CustomSnackBar.showErrorSnackBar(
                          title: '미입력 항목',
                          message: '신고 내용을 입력해주세요.',
                        );
                        return;
                      }
                    }
                    Get.dialog(
                      AlertDialog(
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
                              controller
                                  .reportGame(
                                boardId,
                                controller.reportReason.value,
                              )
                                  .then((value) {
                                // 새로고침 (allListController가 생성되어있으므로 사용)
                                AllListController.to.refreshList();
                                Get.back();
                                Get.back();
                                if (value) {
                                  if (Get.currentRoute == '/game_detail') {
                                    Get.back();
                                  }
                                  // CustomSnackBar.showSuccessSnackBar(
                                  //   title: '신고 성공',
                                  //   message: '신고가 접수되었습니다.',
                                  // );
                                  Get.dialog(
                                    checkDialogWidget(
                                      title: '신고완료',
                                      content: '검토까지 최대 24시간이 소요될 수 있습니다.',
                                      confirmText: '확인',
                                    ),
                                  );
                                } else {
                                  CustomSnackBar.showErrorSnackBar(
                                    title: '신고 실패',
                                    message: '신고 접수에 실패했습니다.',
                                  );
                                }
                              });
                            },
                            child: const Text('확인',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                    // 신고 사유 선택 후 신고 버튼 클릭 시 한번 더 물어보기
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
