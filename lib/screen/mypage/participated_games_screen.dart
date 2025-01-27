import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/list/theme_list_controller.dart';
import 'package:yangjataekil/widget/game/list_item_widget.dart';

class ParticipatedGamesScreen extends GetView<ThemeListController> {
  const ParticipatedGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text('참가한 게임',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () {
          // 게임 목록이 비어있는 경우
          if (controller.participatedBoards.isEmpty) {
            return Container(
              padding: const EdgeInsets.only(bottom: 30),
              color: Colors.white,
              child: const Center(
                child: Text(
                  '참가한 게임이 없습니다.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            );
          }

          // 게임 목록이 있는 경우
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.separated(
              separatorBuilder: (_, index) => const SizedBox(
                height: 20,
              ),
              itemCount: controller.participatedBoards.length,
              itemBuilder: (_, index) {
                return ListItemWidget(
                  controller: controller,
                  index: index,
                  isMyGame: false,
                  isParticipated: true,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
