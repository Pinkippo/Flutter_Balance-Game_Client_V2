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

  /// 컨텐츠 정보
  RxList<BoardContent> boardContent = <BoardContent>[].obs;

  /// 현재 페이지
  Rx<int> currentPage = 0.obs;

  /// 선택한 결과 리스트 -> 0 : 상단 / 1 : 하단
  RxList<int> selectedResult = <int>[].obs;

  /// 결과 선택
  void selectResult(int index, int resultIndex) {

    print("인덱스 >> $index  / 선택한 결과 >> $resultIndex");
    selectedResult[index] = resultIndex;

    if(boardContent.length == index + 1) {
      Get.snackbar(
        '게임 결과',
        '게임이 종료되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } else {

      currentPage.value = currentPage.value + 1;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
  }

  /// 결과 리셋
  void resetResult() {

    print("지금까지 고른 결과 : $selectedResult");

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
  Future<bool> getGameContent(String boardId) async {

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
      boardContent.value = value;
      selectedResult.value = List<int>.filled(boardContent.length, -1);
    });

    return true;
  }
}
