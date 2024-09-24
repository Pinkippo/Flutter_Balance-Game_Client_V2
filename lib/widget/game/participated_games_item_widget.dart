import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/all_list_controller.dart';
import 'package:yangjataekil/controller/theme_list_controller.dart';

import '../list/keyword_widget.dart';

class ParticipatedGamesItemWidget extends StatelessWidget {
  const ParticipatedGamesItemWidget(
      {super.key, required this.controller, required this.index});

  final ThemeListController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 게임 상세 이동
        Get.toNamed('/game_detail', arguments: {
          'boardId': controller.participatedBoards[index].boardId.toString(),
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
              controller.participatedBoards[index].title,
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
              children: controller.participatedBoards[index].keywords
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
                    text: controller.participatedBoards[index].introduce,
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
