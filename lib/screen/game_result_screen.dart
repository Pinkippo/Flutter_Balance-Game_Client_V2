import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_play_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class GameResultScreen extends GetView<GamePlayController> {
  const GameResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Container(
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
            ),
          ),
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                /// 상단 공백
                const SizedBox(height: 100),

                /// 게임 참여 완료 텍스트 및 아이콘
                Column(
                  children: [
                    const Text(
                      '참여가 완료되었습니다!!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 100,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// 게임 선택 결과 리스트
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.boardContent.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.boardContent[index].title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              /// 첫 번째 항목
                              Expanded(
                                flex: controller.boardContent[index]
                                    .boardContentItems[0].boardResultCount,
                                child: Container(
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: AppColors.gamePlayBarColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              /// 두 번째 항목
                              Expanded(
                                flex: controller.boardContent[index]
                                    .boardContentItems[1].boardResultCount,
                                child: Container(
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: AppColors.gamePlayYellowColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.boardContent[index]
                                    .boardContentItems[0].item,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                controller.boardContent[index]
                                    .boardContentItems[1].item,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                /// 하단 버튼 영역
                const SizedBox(height: 100),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              decoration: const BoxDecoration(
                color: AppColors.gamePlayYellowColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: const Text('돌아가기'),
                    ),
                  ),
                  (!controller.isReviewExist.value)
                      ? Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    /// TODO : 리뷰 수정 페이지 이동
                                  },
                                  child: const Text('리뷰쓰기'),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
