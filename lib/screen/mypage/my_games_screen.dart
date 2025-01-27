import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/widget/dialog/custom_dialog_widget.dart';

import '../../../controller/list/theme_list_controller.dart';
import '../../../widget/game/list_item_widget.dart';

class MyGamesScreen extends GetView<ThemeListController> {
  const MyGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text('내 게임',
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
          if (controller.myBoards.isEmpty) {
            return Container(
              padding: const EdgeInsets.only(bottom: 30),
              color: Colors.white,
              child: const Center(
                child: Text('내 게임이 없습니다.',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
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
              itemCount: controller.myBoards.length,
              itemBuilder: (_, index) {
                return Stack(
                  fit: StackFit.passthrough,
                  children: [
                    ListItemWidget(
                      controller: controller,
                      index: index,
                      isMyGame: true,
                      isParticipated: false,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
