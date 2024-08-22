import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_play_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class GamePlayScreen extends GetView<GamePlayController> {
  const GamePlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 앱바
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: Colors.transparent,
        ),
      ),

      body: Obx(
        () => Stack(
          alignment: Alignment.topCenter,
          children: [

            /// 게임 플레이 영역
            Positioned(
              top: 200,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      /// 상단 버튼
                      GestureDetector(
                        onTap: () async {
                          controller.selectResult(index, 0);
                        },
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              controller.boardContent[index].boardContentItems[0].item,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// 하단 버튼
                      GestureDetector(
                        onTap: () async {
                          controller.selectResult(index, 1);
                        },
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              controller.boardContent[index].boardContentItems[1].item,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black.withOpacity(0.6), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '${controller.currentPage.value + 1} ROUND',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Text(
                      controller.boardContent[controller.currentPage.value].title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

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
              ),
            ),
          ],
        ),
      ),

      /// 되돌리기
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.resetResult();
        },
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
