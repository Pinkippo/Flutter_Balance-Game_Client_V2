import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/widget/game/empty_review_hashtag_widget.dart';

import '../../controller/game_review_controller.dart';

class GameReviewHashtag extends GetView<GameReviewController> {
  const GameReviewHashtag({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        child: controller.keywordList.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: EmptyGameReviewHashWidget(),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.keywordList.length + 1,
                itemBuilder: (context, index) {
                  return index == controller.keywordList.length
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: EmptyGameReviewHashWidget(),
                        )
                      : Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '#${controller.keywordList[index]}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  controller.keywordList.removeAt(index);
                                },
                                child: Icon(Icons.cancel,
                                    color: Colors.black.withOpacity(0.2)),
                                // child: Icon(Icons.close_rounded,
                                //     color: Colors.black.withOpacity(0.5), size: 23,),
                              ),
                            ),
                          ],
                        );
                },
              ),
      ),
    );
  }
}
