import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/game/game_play_request_model.dart';
import 'package:yangjataekil/data/provider/game_repository.dart';
import 'package:yangjataekil/data/model/game/game_play_content_response_model.dart';
import 'package:yangjataekil/route/app_pages.dart';

class GamePlayController extends GetxController {

  static GamePlayController get to => Get.find();

  /// 스크롤 컨트롤러
  final gamePlayScrollController = ScrollController();

  /// 페이지 컨트롤러
  final pageController = PageController();

  /// 로딩 간 클릭 제어
  RxBool isLoading = false.obs;

  /// 퍼센트
  RxDouble firstPercentage = 0.0.obs;
  RxDouble secondPercentage = 0.0.obs;

  /// 게임 타이틀
  RxString gameTitle = ''.obs;

  /// boardId
  RxString gameBoardId = ''.obs;

  /// 컨텐츠 정보
  RxList<BoardContent> boardContent = <BoardContent>[].obs;

  /// 리뷰 가능 여부
  RxBool isReviewExist = false.obs;

  /// 현재 페이지
  Rx<int> currentPage = 0.obs;

  /// 선택한 결과 리스트
  RxList<GamePlayRequestModel> selectedResult = <GamePlayRequestModel>[].obs;

  /// 결과 선택
  void selectResult(int index, int resultIndex) async {
    // 로딩간 클릭 처리
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      selectedResult[index] = GamePlayRequestModel(
        boardContentId: boardContent[index].boardContentId,
        boardContentItemId: boardContent[index]
            .boardContentItems[resultIndex]
            .boardContentItemId,
      );

      final total = boardContent[index].boardContentItems[0].boardResultCount +
          boardContent[index].boardContentItems[1].boardResultCount +
          1;

      final firstAdjustment = resultIndex == 0 ? 1 : 0;
      final secondAdjustment = resultIndex == 1 ? 1 : 0;

      firstPercentage.value =
          ((boardContent[index].boardContentItems[0].boardResultCount +
                      firstAdjustment) /
                  total) *
              100;
      secondPercentage.value =
          ((boardContent[index].boardContentItems[1].boardResultCount +
                      secondAdjustment) /
                  total) *
              100;

      await Future.delayed(const Duration(seconds: 2));

      if (boardContent.length == index + 1) {
        // 게임 결과 제출
        BoardContentResponse result = await GameRepository().postGameResult(
          gameBoardId.value,
          selectedResult,
          AuthController.to.accessToken.value,
        );

        if (result.boardContents.isNotEmpty) {
          boardContent.value = result.boardContents;
          await resetResult();
          Get.offAndToNamed(Routes.gameResult);
        }
      } else {
        currentPage.value = currentPage.value + 1;
        firstPercentage.value = 0.0;
        secondPercentage.value = 0.0;
        await pageController.animateToPage(
          currentPage.value,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    } catch (e) {
      print('게임 제출 에러 발생 game_play_controller: $e');
    } finally {
      // 퍼센트 및 로딩 초기화
      firstPercentage.value = 0.0;
      secondPercentage.value = 0.0;
      isLoading.value = false;
    }
  }

  /// 결과 리셋
  Future<void> resetResult() async {
    /// 전체를 다시 -1로 변경
    selectedResult.value = List<GamePlayRequestModel>.filled(boardContent.length, GamePlayRequestModel(boardContentId: -1, boardContentItemId: -1));
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
          gameBoardId.value = boardId;
          selectedResult.value = List<GamePlayRequestModel>.filled(boardContent.length, GamePlayRequestModel(boardContentId: -1, boardContentItemId: -1));
    });

    return true;
  }
}
