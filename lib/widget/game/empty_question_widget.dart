import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game/game_upload_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class EmptyQuestionWidget extends GetView<GameUploadController> {
  const EmptyQuestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.addQuestion();
            controller.scrollToBottom();
          },
          child: SizedBox(
          height: 70,
          child: DottedBorder(
            borderType: BorderType.RRect,
            strokeWidth: 3,
            dashPattern: const [6, 3, 6, 3],
            radius: const Radius.circular(10),
            color: AppColors.gameGreyColor,
            padding: const EdgeInsets.all(6),
            child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '질문 추가하기',
                      style: TextStyle(
                        color: AppColors.gameGreyColor,
                        fontSize: 15,
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: AppColors.gameGreyColor,
                    ),
                  ],
                )),
          ),
        ),
      ),
    ),);
  }
}
