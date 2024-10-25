import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

import '../../controller/game_review_controller.dart';

class EmptyGameReviewHashWidget extends GetView<GameReviewController> {
  const EmptyGameReviewHashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showHashtagDialog(),
          child: SizedBox(
            width: 70,
            height: 40,
            child: DottedBorder(
              borderType: BorderType.RRect,
              strokeWidth: 3,
              dashPattern: const [6, 3, 6, 3],
              radius: const Radius.circular(20),
              color: AppColors.gameGreyColor,
              padding: const EdgeInsets.all(6),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.gameGreyColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showHashtagDialog() {
    final hashtagController = TextEditingController();
    Get.defaultDialog(
      title: '해시태그 추가',
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: TextField(
        controller: hashtagController,
        decoration: const InputDecoration(
          hintText: '해시태그를 입력해주세요.',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            '취소',
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (hashtagController.text.isNotEmpty) {
              controller.addKeyword(hashtagController.text);
              Get.back();
            } else {
              CustomSnackBar.showSnackBar(message: '해시태그를 입력해주세요.');
            }
          },
          child: const Text(
            '확인',
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
