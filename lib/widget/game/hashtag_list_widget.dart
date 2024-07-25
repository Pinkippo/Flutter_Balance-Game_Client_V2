import 'package:flutter/cupertino.dart';
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
        height: 40,
        child: controller.keyword.isEmpty
            ? const EmptyHashWidget()
            : ListView.builder(
                itemCount: controller.keyword.length + 1,
                itemBuilder: (context, index) {
                  return index == controller.keyword.length
                      ? const EmptyHashWidget()
                      : Container(
                          margin: const EdgeInsets.only(right: 10),
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
                        );
                },
                scrollDirection: Axis.horizontal,
              ),
      ),
    );
  }
}
