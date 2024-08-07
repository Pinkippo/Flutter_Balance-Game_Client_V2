import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controller/list_controller.dart';
import '../list/keyword_widget.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget(
      {super.key,
      required this.controller,
      required this.index,
      required this.isFiltered});

  final ListController controller;
  final int index;
  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 게임 상세 이동
        Get.toNamed('/game_detail', arguments: controller.boards[index]);
      },
      child: Container(
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
              isFiltered
                  ? controller.filteredGames[index].title
                  : controller.boards[index].title,
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
              children: isFiltered
                  ? controller.filteredGames[index].keywords
                      .map((keyword) => KeywordWidget(keyword: keyword))
                      .toList()
                  : controller.boards[index].keywords
                      .map((keyword) => KeywordWidget(keyword: keyword))
                      .toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                text: TextSpan(
                    text: isFiltered
                        ? controller.filteredGames[index].introduce
                        : controller.boards[index].introduce,
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
