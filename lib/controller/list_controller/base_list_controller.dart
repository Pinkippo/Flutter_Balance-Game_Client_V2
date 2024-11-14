import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';
import 'package:yangjataekil/controller/list_controller/all_list_controller.dart';
import 'package:yangjataekil/controller/list_controller/list_type_controller.dart';
import 'package:yangjataekil/controller/list_controller/theme_list_controller.dart';
import 'package:yangjataekil/data/model/board/board.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';
import 'package:yangjataekil/data/provider/list.repository.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

abstract class BaseListController extends GetxController {
  /// 페이지 당 게시글 수
  final Rx<int> size = 10.obs;

  /// 현재 페이지
  final Rx<int> page = 0.obs;

  /// 총 페이지 수
  final Rx<int> totalPage = 1.obs;

  /// 정렬 조건
  final Rx<SORTCONDITION?> sortCondition =
      Rx<SORTCONDITION?>(SORTCONDITION.LIKE);

  /// 로딩 상태
  final RxBool isLoading = false.obs;

  /// 게임 리스트
  final RxList<Board> boards = <Board>[].obs;
  final RxList<Board> myBoards = <Board>[].obs; // 내가 쓴 게임 리스트
  final RxList<Board> participatedBoards = <Board>[].obs; // 참여한 게임 리스트

  /// 스크롤 컨트롤러
  final Rx<ScrollController> scrollController = ScrollController().obs;

  /// 게임 리스트 가져오기
  Future<void> getList({bool isRefresh = false});

  /// 정렬 조건 업데이트
  void updateSortCondition(SORTCONDITION condition);

  /// 내가 쓴 게임 삭제
  Future<void> deleteMyGame(int boardId) async {
    try {
      final response = await ListRepository()
          .deleteMyGame(AuthController.to.accessToken.value, boardId);
      print('게임 삭제 boardId: $boardId');

      // 팝업 닫기
      Get.back();

      if (response) {
        if (Get.currentRoute == '/game_detail') {
          print('리스트 타입: ${ListTypeController.to.gameListType.value}');
          switch (ListTypeController.to.gameListType.value) {
            case GameListType.all:
              await refreshAllGameList();
              break;
            case GameListType.theme:
              await refreshThemeGameList();
              await refreshAllGameList();
              break;
            case GameListType.myGames:
              await refreshMyGameList();
              await refreshAllGameList();
          }
          Get.back();
        } else {
          if (Get.currentRoute == '/my_games') {
            await refreshMyGameList();
          }
          boards.clear();
          page.value = 0;
          await getList();
        }
      }
    } catch (e) {
      print('게임 삭제 실패 (catch)');
      CustomSnackBar.showErrorSnackBar(message: "게임을 삭제할 수 없습니다.\n 다시 시도해주세요.");
    }
  }

  /// 전체 게임 리스트 새로고침
  Future<void> refreshAllGameList() async {
    AllListController.to.boards.clear();
    AllListController.to.page.value = 0;
    await AllListController.to.getList();
  }

  /// 테마별 게임 리스트 새로고침
  Future<void> refreshThemeGameList() async {
    ThemeListController.to.boards.clear();
    ThemeListController.to.page.value = 0;
    await ThemeListController.to.getList();
  }

  /// 내가 쓴 게임 리스트 새로고침
  Future<void> refreshMyGameList() async {
    ThemeListController.to.getMyGames();
  }
}
