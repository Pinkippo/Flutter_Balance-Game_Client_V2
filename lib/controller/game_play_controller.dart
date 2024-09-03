import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/provider/game_repository.dart';
import 'package:yangjataekil/data/model/game/game_play_content_response_model.dart';

class GamePlayController extends GetxController {

  static GamePlayController get to => Get.find();

  /// 스크롤 컨트롤러
  final gamePlayScrollController = ScrollController();

  /// 페이지 컨트롤러
  final pageController = PageController();

  /// 퍼센트
  RxDouble firstPercentage = 0.0.obs;
  RxDouble secondPercentage = 0.0.obs;

  /// 게임 타이틀
  RxString gameTitle = ''.obs;

  /// 컨텐츠 정보
  RxList<BoardContent> boardContent = <BoardContent>[].obs;

  /// 리뷰 가능 여부
  RxBool isReviewExist = false.obs;

  /// 현재 페이지
  Rx<int> currentPage = 0.obs;

  /// 선택한 결과 리스트 -> 0 : 상단 / 1 : 하단
  RxList<int> selectedResult = <int>[].obs;

  /// 결과 선택
  void selectResult(int index, int resultIndex) async {

    selectedResult[index] = resultIndex;

    final total = boardContent[index].boardContentItems[0].boardResultCount +
        boardContent[index].boardContentItems[1].boardResultCount + 1;

    final firstAdjustment = resultIndex == 0 ? 1 : 0;
    final secondAdjustment = resultIndex == 1 ? 1 : 0;

    firstPercentage.value = ((boardContent[index].boardContentItems[0].boardResultCount + firstAdjustment) / total) * 100;
    secondPercentage.value = ((boardContent[index].boardContentItems[1].boardResultCount + secondAdjustment) / total) * 100;

    /// 2초 후 결과 리셋
    Future.delayed(const Duration(seconds: 2), () {
      if(boardContent.length == index + 1) {
        Get.snackbar(
          '게임 결과',
          '게임이 종료되었습니다.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );

        /// TODO : 게임 결과 제출

      } else {
        currentPage.value = currentPage.value + 1;
        pageController.animateToPage(
          currentPage.value,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
      /// 퍼센트 초기화
      firstPercentage.value = 0.0;
      secondPercentage.value = 0.0;
    });
  }

  /// 결과 리셋
  Future<void> resetResult() async {
    /// 전체를 다시 -1로 변경
    selectedResult.value = List<int>.filled(boardContent.length, -1);
    currentPage.value = 0;
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  /// 컨텐츠 조회
  Future<bool> getGameContent(String boardId, String title) async {

    if (boardId == '') {
      Get.snackbar(
        '컨텐츠 조회 오류',
        '잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    await GameRepository()
        .getGameContent(boardId, AuthController.to.accessToken.value)
        .then((value) {

          debugPrint("게임 컨텐츠 조회 >> ${value.boardContents} / ${value.isReviewExist}");

          boardContent.value = value.boardContents;
          isReviewExist.value = value.isReviewExist;
          gameTitle.value = title;

          selectedResult.value = List<int>.filled(boardContent.length, -1);
    });

    return true;
  }
}
