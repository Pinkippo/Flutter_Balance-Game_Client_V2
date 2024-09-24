import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/all_list_controller.dart';
import 'package:yangjataekil/controller/theme_list_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

import '../list/keyword_widget.dart';

class ParticipatedGamesItemWidget extends StatelessWidget {
  const ParticipatedGamesItemWidget(
      {super.key, required this.controller, required this.index});

  final ThemeListController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // /// 게임 상세 이동
        // Get.toNamed('/game_detail', arguments: {
        //   'boardId': controller.participatedBoards[index].boardId.toString(),
        // });
        if (controller.participatedBoards[index].isReviewExist == true) {
          Get.toNamed('/game_detail', arguments: {
            'boardId': controller.participatedBoards[index].boardId.toString(),
          });
        } else {
          Get.dialog(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,
              title: const Text('리뷰작성',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              content: const Text('아직 리뷰가 작성되지 않은 게임입니다.\n리뷰를 작성하시겠어요?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  )),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () =>
                              Get.toNamed('/game_detail', arguments: {
                            'boardId': controller
                                .participatedBoards[index].boardId
                                .toString(),
                          }),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: Text('게임보기'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            /// 게임 리뷰 작성 페이지 이동
                            Get.toNamed('/game_review', arguments: {
                              'boardId': controller
                                  .participatedBoards[index].boardId
                                  .toString(),
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: Text('작성하기'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.participatedBoards[index].title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.participatedBoards[index].keywords
                  .map((keyword) => KeywordWidget(
                        keyword: keyword,
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                text: TextSpan(
                    text: controller.participatedBoards[index].introduce,
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
