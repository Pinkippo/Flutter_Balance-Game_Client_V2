import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_detail_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class GameDetailScreen extends GetView<GameDetailController> {
  const GameDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 앱바
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.secondaryColor,
        ),
      ),

      /// 바디
      body: SingleChildScrollView(
        controller: controller.gameDetailScrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 게임 소개
            Container(
              height: 400,
              color: AppColors.secondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    height: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.profileBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text('게임하러 가기',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            /// 게임 리뷰 종합
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            /// 게임 리뷰 리스트
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                controller: controller.reviewScrollController,
                itemBuilder: (context, index) {
                  return Container(
                      width: 120,
                      height: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.13),
                        ),
                      ),
                      child: Container(
                        color: AppColors.gameGreyColor,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
