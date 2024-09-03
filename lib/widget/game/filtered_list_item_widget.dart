import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:yangjataekil/controller/filtered_list_controller.dart';

import '../../controller/all_list_controller.dart';
import '../../controller/theme_list_controller.dart';
import '../list/keyword_widget.dart';

class FilteredListItemWidget extends StatelessWidget {
  const FilteredListItemWidget(
      {super.key,
      this.themeListController,
      this.filteredListController,
      required this.index,
      required this.isFiltered,
      required this.isMyGame});

  final ThemeListController? themeListController;
  final FilteredListController? filteredListController;
  final int index;
  final bool isFiltered;
  final bool isMyGame;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 게임 상세 이동
        Get.toNamed('/game_detail', arguments: {
          'boardId': isFiltered
              ? filteredListController?.filteredList[index].boardId.toString()
              : isMyGame
                  ? themeListController?.myBoards[index].boardId.toString()
                  : themeListController?.boards[index].boardId.toString(),
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
              isFiltered
                  ? filteredListController?.filteredList[index].title ??
                      'Unknown Title'
                  : isMyGame
                      ? themeListController?.myBoards[index].title ??
                          'Unknown Title'
                      : themeListController?.boards[index].title ??
                          'Unknown Title',
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
                  ? (filteredListController?.filteredList[index].keywords ?? [])
                      .map((keyword) => KeywordWidget(keyword: keyword))
                      .toList()
                  : isMyGame
                      ? (themeListController?.myBoards[index].keywords ?? [])
                          .map((keyword) => KeywordWidget(keyword: keyword))
                          .toList()
                      : (themeListController?.boards[index].keywords ?? [])
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
                        ? filteredListController?.filteredList[index].introduce
                        : isMyGame
                            ? themeListController?.myBoards[index].introduce
                            : themeListController?.boards[index].introduce,
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
