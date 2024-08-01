import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/list_controller.dart';
import 'package:yangjataekil/widget/list/keyword_widget.dart';

import '../controller/tab/theme_list_controller.dart';

class ListScreen extends GetView<ListController> {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('${ThemeListController.to.getThemeName()} 벨런스 게임',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                            '별점 높은 순',
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
      body: Obx(
        () => Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.separated(
            controller: controller.scrollController.value,
            separatorBuilder: (_, index) => const SizedBox(
              height: 20,
            ),
            itemCount: controller.boards.length,
            itemBuilder: (_, index) {
              if (index < controller.boards.length + 1) {
                return Container(
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
                        controller.boards[index].title,
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
                        children: [
                          ...controller.boards[index].keywords.map(
                            (keyword) => KeywordWidget(keyword: keyword),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          text: TextSpan(
                              text: controller.boards[index].introduce,
                              style: const TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
