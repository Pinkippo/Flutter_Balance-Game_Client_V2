import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_upload_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/game/empty_hash_widget.dart';

import '../../controller/game_review_controller.dart';

class HashtagList extends StatelessWidget {
  const HashtagList({super.key, required this.controller});

  final controller;

  @override
  Widget build(BuildContext context) {
    if (controller == GameUploadController) {
      Get.put(GameUploadController());
    } else {
      Get.put(GameReviewController());
    }

    return Obx(
      () => SizedBox(
        height: 50,
        child: controller.keyword.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: EmptyHashWidget(controller: controller),
              )
            : ListView.builder(
                itemCount: controller.keyword.length + 1,
                itemBuilder: (context, index) {
                  return index == controller.keyword.length
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: EmptyHashWidget(controller: controller),
                        )
                      : Stack(
                          children: [
                            Container(
                              // color: Colors.black,
                              // height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                // margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: controller == GameUploadController
                                      ? AppColors.primaryColor
                                      : Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '#${controller.keyword[index]}',
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
                                  controller.keyword.removeAt(index);
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
                scrollDirection: Axis.horizontal,
              ),
      ),
    );
  }
}
