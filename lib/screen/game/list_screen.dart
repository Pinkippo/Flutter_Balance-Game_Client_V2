import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/auth_controller.dart';
import 'package:yangjataekil/controller/list/theme_list_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/game/custom_search_widget.dart';
import 'package:yangjataekil/widget/game/list_item_widget.dart';

import '../../controller/game/theme_controller.dart';
import '../../data/model/board/list_board_request_model.dart';

class ListScreen extends GetView<ThemeListController> {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text('${ThemeController.to.getThemeName()} 벨런스 게임',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // 검색을 위해 검색 창 표시
                showSearch(
                  context: context,
                  delegate: CustomSearchWidget(),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(10, 20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: IntrinsicHeight(
                child: Obx(
                  () {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.updateSortCondition(SORTCONDITION.LIKE);
                          },
                          child: Text(
                            '좋아요순',
                            style: TextStyle(
                              color: controller.sortCondition.value ==
                                      SORTCONDITION.LIKE
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.updateSortCondition(SORTCONDITION.DATE);
                          },
                          child: Text(
                            '최신순',
                            style: TextStyle(
                              color: controller.sortCondition.value ==
                                      SORTCONDITION.DATE
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          AuthController.to.accessToken.value.isEmpty
              ? Get.toNamed('/login')
              : Get.toNamed('/upload_game');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Obx(
        () => controller.boards.isEmpty && controller.isLoading.value == false
            ? Container(
                padding: const EdgeInsets.only(bottom: 40),
                color: Colors.white,
                child: const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    '게임이 없습니다.\n게임을 직접 만들어보세요!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: AppColors.primaryColor,
                  onRefresh: () async {
                    controller.boards.clear();
                    controller.page.value = 0;
                    await controller.getList(isRefresh: true);
                  },
                  child: controller.isLoading.value == true
                      ? Container(
                          color: Colors.white,
                        )
                      : ListView.separated(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: controller.scrollController.value,
                          separatorBuilder: (_, index) => const SizedBox(
                            height: 20,
                          ),
                          itemCount: controller.boards.length,
                          itemBuilder: (_, index) {
                            if (index < controller.boards.length + 1) {
                              return ListItemWidget(
                                controller: controller,
                                index: index,
                                isMyGame: false,
                                isParticipated: false,
                              );
                            }
                            return null;
                          },
                        ),
                ),
              ),
      ),
    );
  }
}
