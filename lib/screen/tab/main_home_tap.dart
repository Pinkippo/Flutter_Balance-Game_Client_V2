import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/tab/theme_list_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/home/theme_list_widget.dart';
import 'package:yangjataekil/widget/home/home_header_widget.dart';
import 'package:yangjataekil/widget/home/middle_stack_widget.dart';
import 'package:yangjataekil/widget/home/user_review_widget.dart';

import '../../widget/home/recommended_game_widget.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeListController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // 오버 스크롤 방지
        child: Stack(
          children: [
            SizedBox(
              child: Column(
                children: [
                  /// 상단 부분
                  const HomeHeader(),

                  /// 하단 부분
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 80),
                    child: const Column(
                      children: [
                        Column(
                          children: [
                            GameByTheme(), // 테마별 게임
                            RecommendedGame(), // 추천 게임
                            UserReview(), // 사용자 리뷰
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// 중간 스택 부분
            const MiddleStackContent(),
          ],
        ),
      ),
    );
  }
}
