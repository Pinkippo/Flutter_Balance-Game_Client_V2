import 'dart:math';

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
                // 로그인 검증
                if (AuthController.to.accessToken.isEmpty) {
                  Get.toNamed('/login');
                } else {
                  if (value == '리뷰작성') {
                    Get.toNamed('/game_review', arguments: {
                      'boardId': controller.gameDetail.value.boardId
                    });
                  } else if (value == '신고하기') {
                    Get.dialog(
                      PopScope(
                          onPopInvokedWithResult:
                              (bool didPop, dynamic result) {
                            controller.selectedCategory.value = null;
                            controller.content.value = '';
                          },
                          child: reportGameDialog(context, controller)),
                    );
                  }
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

                                if(AuthController.to.accessToken.isEmpty){
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
                            }else{
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

                        Expanded(
                          flex: 2,
                          child: Padding(
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
                                  "키워드로 먼저\n리뷰를 봐요",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "참여자 ${controller.gameDetail.value.boardReviewCount}명",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (controller.gameDetail.value.boardReviewsPreview.isEmpty) {
                                return Center(
                                  child: CircleAvatar(
                                    radius: min(constraints.maxWidth * 0.3, constraints.maxHeight * 0.3),
                                    backgroundColor: Colors.lightBlueAccent.withOpacity(0.5),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "리뷰가 존재하지\n않습니다",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            height: 1.2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return Stack(
                                clipBehavior: Clip.none,
                                children: [

                                  if (controller.gameDetail.value.boardReviewsPreview.isNotEmpty)
                                    Positioned(
                                      left: constraints.maxWidth * 0.1,
                                      top: constraints.maxHeight * 0.1,
                                      child: CircleAvatar(
                                        radius: min(constraints.maxWidth * 0.28, constraints.maxHeight * 0.28),
                                        backgroundColor: Colors.lightBlueAccent.withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              controller.gameDetail.value.boardReviewsPreview[0].keyword ?? "",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                height: 1.2,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  if (controller.gameDetail.value.boardReviewsPreview.length > 1)
                                    Positioned(
                                      left: _getLeftValue(constraints),
                                      top: constraints.maxHeight * 0.35,
                                      child: CircleAvatar(
                                        radius: min(constraints.maxWidth * 0.24, constraints.maxHeight * 0.24),
                                        backgroundColor: Colors.blue.withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              controller.gameDetail.value.boardReviewsPreview[1].keyword ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                height: 1.2,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  if (controller.gameDetail.value.boardReviewsPreview.length > 2)
                                    Positioned(
                                      left: constraints.maxWidth * 0.2,
                                      bottom: constraints.maxHeight * 0.2,
                                      child: CircleAvatar(
                                        radius: min(constraints.maxWidth * 0.16, constraints.maxHeight * 0.16),
                                        backgroundColor: Colors.tealAccent.withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              controller.gameDetail.value.boardReviewsPreview[2].keyword ?? "",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                height: 1.2,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
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
                      ],
                    ),
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
                  itemCount: controller.relatedGameList.length,
                  controller: controller.reviewScrollController,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await controller.changeGameDetail(controller
                            .relatedGameList[index].boardId
                            .toString());
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
                          child: Center(
                            child: Text(
                              /// 게임 제목
                              controller.relatedGameList[index].introduce,
                              style: const TextStyle(
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
      ),
    );
  }

  double _getLeftValue(BoxConstraints constraints) {
    if (Get.width > 600) {
      return constraints.maxWidth * 0.3;
    } else {
      return constraints.maxWidth * 0.4;
    }
  }
}
