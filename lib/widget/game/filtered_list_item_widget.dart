import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/filtered_list_controller.dart';
import 'package:yangjataekil/controller/theme_list_controller.dart';

import '../list/keyword_widget.dart';

class FilteredListItemWidget extends StatelessWidget {
  const FilteredListItemWidget({
    super.key,
    this.themeListController,
    this.filteredListController,
    required this.index,
    required this.isFiltered,
    required this.isMyGame,
  });

  final ThemeListController? themeListController;
  final FilteredListController? filteredListController;
  final int index;
  final bool isFiltered;
  final bool isMyGame;

  @override
  Widget build(BuildContext context) {
    // 각 조건에 따라 적절한 데이터를 가져오는 함수
    final boardData = _getBoardData();

    return GestureDetector(
      onTap: () {
        Get.toNamed('/game_detail', arguments: {
          'boardId': boardData.boardId.toString(),
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
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
                  boardData.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 10),

                // 키워드 리스트 레이아웃 적용
                _buildResponsiveKeywordList(boardData, constraints.maxWidth),

                const SizedBox(height: 10),
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    text: TextSpan(
                      text: boardData.introduce,
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

  // 조건에 따라 적절한 board 데이터를 선택하는 함수
  dynamic _getBoardData() {
    if (isFiltered) {
      return filteredListController?.filteredList[index];
    } else if (isMyGame) {
      return themeListController?.myBoards[index];
    } else {
      return themeListController?.boards[index];
    }
  }

  // 키워드 리스트의 너비를 계산하여 Wrap 또는 ListView로 반환
  Widget _buildResponsiveKeywordList(dynamic boardData, double containerWidth) {
    if (boardData?.keywords == null || boardData.keywords.isEmpty) {
      return const SizedBox.shrink(); // 키워드가 없을 경우 빈 위젯 반환
    }

    // 각 키워드의 너비를 계산하여 전체 키워드의 너비 합산
    final keywordWidgets = boardData.keywords
        .map<Widget>((keyword) => KeywordWidget(keyword: keyword))
        .toList();

    final totalKeywordWidth = _calculateTotalKeywordWidth(boardData.keywords);

    // 키워드의 총 너비가 컨테이너 너비를 초과하면 스크롤 가능하게 ListView로, 초과하지 않으면 Wrap으로 가운데 정렬
    if (totalKeywordWidth < containerWidth) {
      // 키워드가 컨테이너 너비보다 작을 경우, Wrap으로 가운데 정렬
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: keywordWidgets,
      );
    } else {
      // 키워드가 컨테이너 너비보다 클 경우, 스크롤 가능한 ListView로 처리
      return SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: keywordWidgets,
        ),
      );
    }
  }

  // 각 키워드의 너비를 대략적으로 계산하는 함수 (단순 문자열 길이 기준)
  double _calculateTotalKeywordWidth(List<String> keywords) {
    const paddingPerKeyword = 16.0; // 키워드 간 여백
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double totalWidth = 0;

    for (var keyword in keywords) {
      textPainter.text = TextSpan(text: keyword, style: const TextStyle(fontSize: 14));
      textPainter.layout();
      totalWidth += textPainter.width + paddingPerKeyword;
    }

    return totalWidth;
  }
}
