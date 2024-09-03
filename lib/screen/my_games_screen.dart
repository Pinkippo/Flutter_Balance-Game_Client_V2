import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/theme_list_controller.dart';
import '../widget/game/filtered_list_item_widget.dart';

class MyGamesScreen extends GetView<ThemeListController> {
  const MyGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
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
        () => Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.separated(
            separatorBuilder: (_, index) => const SizedBox(
              height: 20,
            ),
            itemCount: controller.myBoards.length,
            itemBuilder: (_, index) {
              if (index < controller.myBoards.length + 1) {
                return FilteredListItemWidget(
                    themeListController: controller, index: index, isFiltered: false, isMyGame: true);
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
