import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/recommend_controller.dart';
import 'package:yangjataekil/widget/bubble_widget.dart';

import '../../theme/app_color.dart';

class RecommendedGame extends GetView<RecommendController> {
  const RecommendedGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                '오늘의 추천 밸런스 게임',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 220,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black.withOpacity(0.13),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('병맛 밸런스 게임?\n궁금하면 들어와',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 15),
                Text(
                  '"나는 이상한(?)게임이 하고 싶다"\n"나는 말이 안 되는 질문이 좋다"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20, right: 30),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       bubbleWidget(
                //           icon: Icons.monetization_on_outlined,
                //           iconColor: Colors.black.withOpacity(0.2),
                //           comment: '게임 참여만 해도 포인트 증정!',
                //           color: const Color(0xFFFFD644)),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 48,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.setRecommendGameId();

                      /// 추천 게임 상세 페이지로 이동
                      Get.toNamed('/game_detail', arguments: {
                        'boardId': controller.recommendGameId.value.toString(),
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('게임하러 가기'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
