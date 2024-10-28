import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/game_detail_controller.dart';
import 'package:yangjataekil/controller/game_play_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/game_detail/game_vertical_info_widget.dart';
import 'package:yangjataekil/widget/report/game_report_dialog_widget.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

class GameDetailScreen extends GetView<GameDetailController> {
  const GameDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// TODO: 리뷰달리 버튼 추가
    return Scaffold(
      backgroundColor: Colors.white,

      /// 앱바
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.secondaryColor,
          surfaceTintColor: AppColors.secondaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            DropdownButton<String>(
              alignment: Alignment.center,
              icon: const Icon(Icons.more_vert, color: Colors.black),
              underline: const SizedBox.shrink(),
              dropdownColor: Colors.white,
              items: <String>['리뷰작성', '신고하기'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: SizedBox(
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? value) async {
                if (value == '리뷰작성') {
                  Get.toNamed('/game_review', arguments: {
                    'boardId': controller.gameDetail.value.boardId
                  });
                } else if (value == '신고하기') {
                  Get.dialog(
                    PopScope(
                        onPopInvokedWithResult: (bool didPop, dynamic result) {
                          controller.selectedCategory.value = null;
                          controller.content.value = '';
                        },
                        child: reportGameDialog(context, controller)),
                  );
                }
              },
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),

      /// 바디
      body: SingleChildScrollView(
        controller: controller.gameDetailScrollController,
        physics: const ClampingScrollPhysics(),
        child: Obx(
          () => Column(
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
                            /// 게임 제목
                            controller.gameDetail.value.title,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const Spacer(),

                          //
                          // ElevatedButton(
                          //     onPressed: () {
                          //       Get.toNamed('/game_review', arguments: {
                          //         'boardId': controller.gameDetail.value.boardId
                          //       });
                          //     },
                          //     child: Text('리뷰달기')),
                          Text(
                            /// 게임 소개
                            controller.gameDetail.value.introduce,
                            style: const TextStyle(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                VerticalInfoWidget(
                                  label: '좋아요',
                                  count: controller.gameDetail.value.likeCount,
                                ),
                                VerticalInfoWidget(
                                  label: '싫어요',
                                  count:
                                      controller.gameDetail.value.dislikeCount,
                                ),
                                VerticalInfoWidget(
                                  label: '조회수',
                                  count: controller.gameDetail.value.viewCount,
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
                        onPressed: () async {
                          /// 게임 플레이 페이지 이동
                          /// TODO : 로딩 화면 수정 고려 필요
                          await Get.showOverlay(
                              asyncFunction: () async {
                                if (AuthController.to.accessToken.isEmpty) {
                                  return false;
                                }

                                /// 최소 로딩 기간 1.5초 보장
                                final gameContentFuture = GamePlayController.to
                                    .getGameContent(
                                        controller.gameDetail.value.boardId
                                            .toString(),
                                        controller.gameDetail.value.title
                                            .toString());
                                final delayFuture = Future.delayed(
                                    const Duration(
                                        seconds: 1, milliseconds: 500));
                                return await Future.wait(
                                        [gameContentFuture, delayFuture])
                                    .then((results) {
                                  return results[0];
                                });
                              },
                              loadingWidget: const Center(
                                child: SpinKitThreeBounce(
                                  color: AppColors.primaryColor,
                                  size: 30.0,
                                ),
                              )).then((value) {
                            if (value == true) {
                              Get.toNamed('/game_play');
                            } else {
                              Get.toNamed('/login');
                            }
                          });
                        },
                        child: const Text('게임하러 가기',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
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
                child: GestureDetector(
                  onTap: () async {
                    // print(controller.gameDetail.value.boardId);
                    await Get.toNamed('/review_list',
                        arguments: controller.gameDetail.value.boardId);
                  },
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
                                "참여자 ${controller.gameDetail.value.boardReviewsPreview.length}명",
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (controller.gameDetail.value
                                  .boardReviewsPreview.isNotEmpty) ...[
                                Positioned(
                                  top: 10,
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundColor:
                                        Colors.lightBlueAccent.withOpacity(0.5),
                                    child: Text(
                                      controller.gameDetail.value
                                              .boardReviewsPreview[0].keyword ??
                                          "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                if (controller.gameDetail.value
                                        .boardReviewsPreview.length >
                                    1)
                                  Positioned(
                                    top: 90,
                                    right: 10,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor:
                                          Colors.blue.withOpacity(0.5),
                                      child: Text(
                                        controller
                                                .gameDetail
                                                .value
                                                .boardReviewsPreview[1]
                                                .keyword ??
                                            "",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                if (controller.gameDetail.value
                                        .boardReviewsPreview.length >
                                    2)
                                  Positioned(
                                    top: 130,
                                    right: 110,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          Colors.tealAccent.withOpacity(0.5),
                                      child: Text(
                                        controller
                                                .gameDetail
                                                .value
                                                .boardReviewsPreview[2]
                                                .keyword ??
                                            "",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                              ] else ...[
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 75,
                                    backgroundColor:
                                        Colors.lightBlueAccent.withOpacity(0.5),
                                    child: const Text(
                                      "리뷰가 존재하지\n않습니다",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              /// 게임 추천 리스트
              Container(
                height: 170,
                child: CarouselSlider.builder(
                  controller: controller.carouselScrollController,
                  itemCount: controller.relatedGameList.length,
                  options: CarouselOptions(
                    height: 400.0,
                    enableInfiniteScroll: false, // 무한 스크롤을 원치 않으면 false로 설정
                    enlargeCenterPage: true, // 중앙 항목을 더 크게 보이도록 설정
                    viewportFraction: 0.64, // 슬라이드 폭의 비율을 설정
                  ),
                  itemBuilder: (context, index, realIndex) {
                    if (controller.relatedGameList.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return GestureDetector(
                      onTap: () async {
                        await controller.changeGameDetail(controller
                            .relatedGameList[index].boardId
                            .toString());
                      },
                      child: Container(
                        width: 230,
                        height: 170,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: AppColors.gameReviewBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: AppColors.gameReviewBorderColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 33,
                                        child: Image.asset(
                                            'assets/images/game/game_controller.png'),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          controller
                                              .relatedGameList[index].title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    controller.relatedGameList[index].introduce,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '좋아요: ${controller.relatedGameList[index].likeCount}개',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
