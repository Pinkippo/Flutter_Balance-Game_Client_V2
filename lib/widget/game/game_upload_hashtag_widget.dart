import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game/game_upload_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/game/empty_game_upload_hash_widget.dart';

import '../../controller/game/game_review_controller.dart';

class GameUploadHashtag extends GetView<GameUploadController> {
  const GameUploadHashtag({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        child: controller.keywordList.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: EmptyGameUploadHashWidget(),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.keywordList.length + 1,
                itemBuilder: (context, index) {
                  return index == controller.keywordList.length
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: EmptyGameUploadHashWidget(),
                        )
                      : Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                // margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
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
