import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_upload_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/game/question_list_widget.dart';
import 'package:yangjataekil/widget/game/hashtag_list_widget.dart';

class UploadGameScreen extends GetView<GameUploadController> {
  const UploadGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '게임 등록',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  controller.updateGameName(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: '게임 이름',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.black.withOpacity(0.1),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                onChanged: (value) {
                  controller.uploadIntroduce(value);
                },
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  hintText: '한줄 소개를 입력해주세요.',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.black.withOpacity(0.1),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                '해시태그와 함께 게임을 소개해보세요.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const HashtagList(),
              const SizedBox(
                height: 30,
              ),
              const Text('질문과 답을 작성해주세요!'),
              const SizedBox(
                height: 10,
              ),
              const QuestionListWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 17),
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('게임 등록하기'),
        ),
      ),
    );
  }
}
