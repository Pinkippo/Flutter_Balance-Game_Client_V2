import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/list_controller/all_list_controller.dart';
import 'package:yangjataekil/widget/dialog/custom_dialog_widget.dart';
import 'package:yangjataekil/widget/report/game_report_dialog_widget.dart';


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

          return Stack(
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
                                  .map((keyword) =>
                                      KeywordWidget(keyword: keyword))
                                  .toList(),
                            ),
                          )
                        : Center(
                            child: Wrap(
                              spacing: 8.0, // 키워드 간의 간격
                              alignment: WrapAlignment.center,
                              children: controller.boards[index].keywords
                                  .map((keyword) =>
                                      KeywordWidget(keyword: keyword))
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
              ),
              // 드롭다운 아이콘
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onPressed: () {
                    _showOptionsBottomSheet();
                  },
                ),
              ),
            ],
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

  // 신고하기 기능

  // 하단 팝업 표시
  void _showOptionsBottomSheet() {
    if (AuthController.to.uid.value == controller.boards[index].userId) {
      Get.bottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.cancel_rounded, color: Colors.red),
                title: const Text('삭제하기'),
                onTap: () {
                  Get.back();
                  MyCustomDialog customDialog = MyCustomDialog();
                  customDialog.showConfirmDialog(
                    title: "게임 삭제",
                    content: "게임을 삭제하시겠습니까?",
                    onConfirm: () async {
                      await controller
                          .deleteMyGame(controller.boards[index].boardId);
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
        ),
      );
    } else {
      Get.bottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        Padding(
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
                              controller.boards[index].boardId, controller)),
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
                      onConfirm: () async => controller
                          .blockGame(controller.boards[index].boardId),
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
}
