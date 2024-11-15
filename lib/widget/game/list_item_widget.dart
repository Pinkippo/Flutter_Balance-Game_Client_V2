import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/list_controller/base_list_controller.dart';
import 'package:yangjataekil/widget/report/game_report_dialog_widget.dart';

import '../dialog/custom_dialog_widget.dart';
import '../list/keyword_widget.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.controller,
    required this.index,
    required this.isMyGame,
    required this.isParticipated,
  });

  final BaseListController controller;
  final int index;
  final bool isMyGame;
  final bool isParticipated;

  @override
  Widget build(BuildContext context) {
    // 조건에 따라 게임 데이터 가져오기
    final boardData = _getBoardData();

    return GestureDetector(
      onTap: () {
        Get.toNamed('/game_detail', arguments: {
          'boardId': boardData.boardId.toString(),
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
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
                    _buildResponsiveKeywordList(
                        boardData, constraints.maxWidth),

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
              ),
              // 드롭다운 아이콘
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onPressed: () {
                    _showOptionsBottomSheet(boardData);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 조건에 따라 게임 데이터를 가져오는 메서드
  dynamic _getBoardData() {
    if (isParticipated) {
      return controller.participatedBoards[index];
    } else if (isMyGame) {
      return controller.myBoards[index];
    } else {
      return controller.boards[index];
    }
  }

  /// 키워드 리스트의 너비를 계산하여 Wrap 또는 ListView로 반환
  Widget _buildResponsiveKeywordList(dynamic boardData, double containerWidth) {
    if (boardData?.keywords == null || boardData.keywords.isEmpty) {
      return const SizedBox.shrink(); // 키워드가 없을 경우 빈 위젯 반환
    }

    // 각 키워드의 너비를 계산하여 전체 키워드의 너비 합산
    final keywordWidgets = boardData.keywords
        .map<Widget>((keyword) => KeywordWidget(keyword: keyword))
        .toList();

    final totalKeywordWidth = _calculateTotalKeywordWidth(boardData.keywords);

    /// 키워드의 총 너비가 컨테이너 너비를 초과하면 스크롤 가능하게 ListView로, 초과하지 않으면 Wrap으로 가운데 정렬
    if (totalKeywordWidth < containerWidth) {
      // 키워드가 컨테이너 너비보다 작을 경우, Wrap으로 가운데 정렬
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: keywordWidgets,
      );
    } else {
      /// 키워드가 컨테이너 너비보다 클 경우, 스크롤 가능한 ListView로 처리
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
      textPainter.text =
          TextSpan(text: keyword, style: const TextStyle(fontSize: 14));
      textPainter.layout();
      totalWidth += textPainter.width + paddingPerKeyword;
    }

    return totalWidth;
  }

  // 하단 팝업 표시
  void _showOptionsBottomSheet(dynamic boardData) {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      AuthController.to.uid.value == boardData.userId
          ? Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.cancel_rounded, color: Colors.red),
                    title: const Text('삭제하기'),
                    onTap: () {
                      Get.back();
                      // 삭제 다이얼로그 표시
                      MyCustomDialog customDialog = MyCustomDialog();
                      customDialog.showConfirmDialog(
                        title: "게임 삭제",
                        content: "게임을 삭제하시겠습니까?",
                        onConfirm: () async {
                          await controller.deleteMyGame(boardData.boardId);
                        },
                        confirmText: "삭제하기",
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.close, color: Colors.grey),
                    title: const Text('취소'),
                    onTap: () {
                      Get.back(); // 팝업 닫기
                    },
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.report, color: Colors.red),
                    title: const Text('신고하기'),
                    onTap: () {
                      Get.back();
                      if (AuthController.to.accessToken.isEmpty) {
                        Get.toNamed('/login');
                      } else {
                        Get.dialog(
                          PopScope(
                              onPopInvokedWithResult:
                                  (bool didPop, dynamic result) {
                                controller.selectedCategory.value = null;
                                controller.reportReason.value = '';
                              },
                              child: reportGameDialog(
                                  boardData.boardId, controller)),
                        );
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.block, color: Colors.orange),
                    title: const Text('차단하기'),
                    onTap: () {
                      // 차단하기 기능
                      Get.back();
                      if (AuthController.to.accessToken.isEmpty) {
                        Get.toNamed('/login');
                      }
                      MyCustomDialog().showConfirmDialog(
                          title: '차단',
                          content: '이 사용자의 게시글을 차단하시겠습니까?',
                          onConfirm: () async =>
                              controller.blockGame(boardData.boardId),
                          confirmText: '차단하기');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.close, color: Colors.grey),
                    title: const Text('취소'),
                    onTap: () {
                      Get.back(); // 팝업 닫기
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
