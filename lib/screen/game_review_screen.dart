import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_review_controller.dart';

import '../widget/game/game_review_hashtag_widget.dart';

class GameReviewScreen extends GetView<GameReviewController> {
  const GameReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면 전체 넓이
    double screenWidth = Get.width;
    // 사용 가능 넓이
    double availableWidth = screenWidth - 30;
    // 버튼 하나의 넓이
    double buttonWidth = availableWidth / 2 - 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0, // 스크롤 시 앱바 그림자 제거
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('리뷰'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('만족도 평가'),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRadio('좋아요', true, buttonWidth),
                  CustomRadio('싫어요', false, buttonWidth),
                ],
              ),
              const SizedBox(height: 40),

              // 태그 선택 파트
              const Text('태그로 알려주세요!'),
              const SizedBox(height: 10),
              const GameReviewHashtag(),

              const SizedBox(height: 40),

              // 리뷰 제목 파트
              const Text('리뷰 제목'),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) => controller.updateReviewTitle(value),
                decoration: const InputDecoration(
                  hintText: '너무 재밌는 밸런스 게임!',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                ),
                maxLength: 20,
              ),
              const SizedBox(height: 40),

              // 리뷰 내용 파트
              const Text('전체 리뷰를 남겨주세요!'),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) => controller.updateReviewContent(value),
                decoration: InputDecoration(
                  filled: true,
                  hintText: '너무 재밌는 밸런스 게임!',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.black.withOpacity(0.1),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 6,
                maxLength: 100,
              ),

              // ElevatedButton(onPressed: () {}, child: child)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            // Get.arguments['boardId']가 이미 int 타입인지 확인하고 처리
            final boardId = Get.arguments['boardId'];
            if (boardId is int) {
              controller.uploadReview(boardId);
            } else {
              controller.uploadReview(int.parse(boardId));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text('리뷰 남기기'),
        ),
      ),
    );
  }

  /// 커스텀 라디오 버튼
  Widget CustomRadio(String text, bool like, double width) {
    return Obx(
          () => SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: () {
            controller.changeLike(like);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: controller.isLike.value == like
                ? (like ? const Color(0xffcedcff) : const Color(0xffffdddd))
                : Colors.white,
            minimumSize: const Size(0, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: controller.isLike.value == like
                  ? (like ? Colors.blueAccent : Colors.redAccent)
                  : Colors.grey,
              width: 2.0,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: controller.isLike.value == like ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
