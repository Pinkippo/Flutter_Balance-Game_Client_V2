import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_upload_controller.dart';

import '../../data/model/upload_game_request_model.dart';

class QuestionItemWidget extends GetView<GameUploadController> {
  final Question question;
  final int index;

  const QuestionItemWidget({
    Key? key,
    required this.question,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 240,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                controller.updateQuestionTitle(index, value);
              },
              decoration: const InputDecoration(
                hintText: '질문을 작성해 주세요!',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                border: InputBorder.none,
              ),
            ),
            ...question.questionItems.asMap().entries.map((entry) {
              int answerIndex = entry.key;
              return TextField(
                onChanged: (value) {
                  controller.updateAnswer(index, answerIndex, value);
                },
                decoration: InputDecoration(
                  hintText:
                      answerIndex == 0 ? '첫번째 답을 입력해 주세요!' : '두번째 답을 입력해 주세요!',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
