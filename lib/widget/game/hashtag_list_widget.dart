import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/game_upload_controller.dart';
import 'package:yangjataekil/widget/game/empty_hash_widget.dart';

class HashtagList extends GetView<GameUploadController> {
  const HashtagList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        child: controller.keyword.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: EmptyHashWidget(),
              )
            : ListView.builder(
                itemCount: controller.keyword.length + 1,
                itemBuilder: (context, index) {
                  return index == controller.keyword.length
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: EmptyHashWidget(),
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
                                  color: const Color(0xffFF9297),
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
