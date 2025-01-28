import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game/game_upload_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/game/empty_question_widget.dart';
import 'package:yangjataekil/widget/game/question_item_widget.dart';

import '../../data/model/game/game_upload_request_model.dart';

class QuestionListWidget extends GetView<GameUploadController> {
  const QuestionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ...controller.boardContent.asMap().entries.map((entry) {
            int index = entry.key;
            Question question = entry.value;
            return Stack(
              children: [
                /// 질문 위젯
                QuestionItemWidget(question: question, index: index),

                /// 질문 번호
                Positioned(
                    left: 8,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      width: 40,
                      height: 40,
                      child: Center(child: Text('${index + 1}')),
                    )),
              ],
            );
          }),

          /// 질문 추가 위젯
          const EmptyQuestionWidget(),
        ],
      ),
    );
  }
}
