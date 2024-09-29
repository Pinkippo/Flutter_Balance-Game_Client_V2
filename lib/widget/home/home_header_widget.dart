import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_color.dart';

/// 홈 화면 상단 위젯
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.secondaryColor,
      height: Get.height * 0.25, // 높이를 화면 높이의 25%로 설정
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                // color: Colors.white,
                width: Get.width * 0.5, // 너비를 화면 너비의 50%로 설정
                height: 55,
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: const Text(
                  '하나만 골라봐! 쉽지만 고민되는 질문들, 너라면?',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                // color: Colors.white,
                width: Get.width * 0.5, // 너비를 화면 너비의 50%로 설정
                height: 55,
                margin: const EdgeInsets.only(left: 20, top: 5),
                child: Text(
                  '재미있었다면 리뷰 한 줄 남겨주세요! 여러분의 선택이 더 많은 고민을 불러올 지 몰라요.☺️',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.white,
            width: Get.width * 0.35, // 너비를 화면 너비의 35%로 설정
            height: Get.width * 0.35, // 높이를 화면 너비의 35%로 설정
            margin: const EdgeInsets.only(right: 20, top: 10),
            child: Image.asset('assets/images/game/in_game_character.png'),
          ),
        ],
      ),
    );
  }
}
