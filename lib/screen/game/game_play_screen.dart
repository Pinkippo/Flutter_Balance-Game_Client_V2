import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game/game_play_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class GamePlayScreen extends GetView<GamePlayController> {
  const GamePlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        await controller.resetResult();
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.gamePlayPinkColor,
                AppColors.gamePlayYellowColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Obx(
            () => Stack(
              alignment: Alignment.topCenter,
              children: [

                /// 왼쪽 상단 뒤로가기 아이콘
                Positioned(
                  top: 60,
                  left: 16,
                  child: GestureDetector(
                    onTap: () async {
                      controller.resetResult().then((value) => Get.back());
                    },
                    child: const Icon(
                      Icons.exit_to_app_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),

                /// 인게임 캐릭터 이미지
                Positioned(
                  top: Get.height * 0.25,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/game/in_game_character.png',
                  ),
                ),

                /// 게임 플레이 영역
                Positioned(
                  top: Get.height * 0.48,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.boardContent.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.gameGreyColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(children: [
                              /// 상단 버튼
                              Obx(
                                () => GestureDetector(
                                  onTap: () async {
                                    controller.selectResult(index, 0);
                                  },
                                  child: Container(
                                    height: 100,
                                    margin:
                                        const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          width:
                                              (controller.firstPercentage.value /
                                                      100) *
                                                  (Get.width - 44),
                                          decoration: BoxDecoration(
                                            color: AppColors.gamePlayBarColor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Center(
                                            child: Text(
                                              controller.boardContent[index]
                                                  .boardContentItems[0].item,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// 하단 버튼
                              Obx(
                                () => GestureDetector(
                                  onTap: () async {
                                    controller.selectResult(index, 1);
                                  },
                                  child: Container(
                                    height: 100,
                                    margin:
                                        const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Stack(
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          width: (controller.secondPercentage /
                                                  100) *
                                              (Get.width - 44),
                                          decoration: BoxDecoration(
                                            color: AppColors.gamePlayBarColor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Center(
                                            child: Text(
                                              controller.boardContent[index]
                                                  .boardContentItems[1].item,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                '${controller.currentPage.value + 1} / ${controller.boardContent.length}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                /// 게임 정보
                Positioned(
                  top: Get.height * 0.11,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.6),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              controller.gameTitle.value,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          controller
                              .boardContent[controller.currentPage.value].title,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// 되돌리기
        floatingActionButton: SizedBox(
          width: Get.width,
          child: Stack(
            children: [
              // 이전 질문 버튼
              Positioned(
                left: 20,
                bottom: 10,
                child: FloatingActionButton(
                  heroTag: 'move_previous',
                  onPressed: () async {
                    controller.moveToPrevious(controller.currentPage.value);
                  },
                  backgroundColor: AppColors.gamePlayPinkColor,
                  child: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
                ),
              ),

              // 리셋 버튼
              Positioned(
                right: 20,
                bottom: 10,
                child: FloatingActionButton(
                  heroTag: 'reset',
                  onPressed: () async {
                    await controller.resetResult();
                  },
                  backgroundColor: AppColors.gamePlayPinkColor,
                  child: const Icon(Icons.refresh, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
