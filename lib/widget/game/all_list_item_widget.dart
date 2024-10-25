import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/list_controller/all_list_controller.dart';

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
          'boardId': controller.boards[index].boardId.toString(),
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // AllListItemWidget의 가로 크기
          final widgetWidth = constraints.maxWidth;

          // 키워드들이 차지하는 총 가로 크기 계산
          final keywordTotalWidth = controller.boards[index].keywords.isEmpty
              ? 0
              : controller.boards[index].keywords
              .map((keyword) => _calculateKeywordWidth(context, keyword))
              .fold(0.0, (a, b) => a + b);

          // 키워드들이 가로 크기를 넘는지 확인
          final isScrollable = keywordTotalWidth > widgetWidth;

          return Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  controller.boards[index].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                isScrollable
                    ? SizedBox(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: controller.boards[index].keywords
                        .map((keyword) => KeywordWidget(keyword: keyword))
                        .toList(),
                  ),
                )
                    : Center(
                  child: Wrap(
                    spacing: 8.0, // 키워드 간의 간격
                    alignment: WrapAlignment.center,
                    children: controller.boards[index].keywords
                        .map((keyword) => KeywordWidget(keyword: keyword))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    text: TextSpan(
                      text: controller.boards[index].introduce,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 각 키워드의 예상 크기 계산 함수
  double _calculateKeywordWidth(BuildContext context, String keyword) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: keyword,
        style: const TextStyle(fontSize: 12), // 키워드 폰트 크기
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width + 16; // 패딩을 고려한 예상 너비 반환
  }
}
