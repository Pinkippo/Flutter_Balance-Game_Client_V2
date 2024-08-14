import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_detail_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/game_detail/game_vertical_info_widget.dart';

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
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          "게임 소개",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "게임 소개 게임 소개 게임 소개 게임 소개 게임 소개 게임 소개 게임 소개 게임 소개 게임 소개 게임 소개 게임 소개 게임 소개 게임 소개",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              VerticalInfoWidget(
                                label: '좋아요',
                                count: 20,
                              ),
                              VerticalInfoWidget(
                                label: '싫어요',
                                count: 20,
                              ),
                              VerticalInfoWidget(
                                label: '조회수',
                                count: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

            /// 게임 리뷰 정리
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "리뷰",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "키워드로 먼저 \n리뷰를 봐요",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "참여자 13명",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 10,
                              left: 20,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor:
                                    Colors.lightBlueAccent.withOpacity(0.5),
                                child: const Text(
                                  "직장상사",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 90,
                              right: 10,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.blue.withOpacity(0.5),
                                child: const Text(
                                  "대머리",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 130,
                              right: 110,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor:
                                    Colors.tealAccent.withOpacity(0.5),
                                child: const Text(
                                  "리뷰",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            /// 게임 추천 리스트
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                controller: controller.reviewScrollController,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      /// TODO : 게임 상세 이동
                    },
                    child: Container(
                        width: 120,
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: AppColors.profileBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.profileBackgroundColor,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "게임 추천 게임 추천 게임 추천 게임 추천 게임 추천 게임 추천 게임 추천 게임 추천 게임 추천",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                          ),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
