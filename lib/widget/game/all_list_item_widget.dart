import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/all_list_controller.dart';

import '../list/keyword_widget.dart';

class AllListItemWidget extends StatelessWidget {
  const AllListItemWidget(
      {super.key, required this.controller, required this.index});

  final AllListController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 게임 상세 이동
        Get.toNamed('/game_detail', arguments: {
          'boardId': controller.allBoards[index].boardId.toString(),
        });
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
              controller.allBoards[index].title,
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
              children: controller.allBoards[index].keywords
                  .map((keyword) => KeywordWidget(
                        keyword: keyword,
                      ))
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
                    text: controller.allBoards[index].introduce,
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
