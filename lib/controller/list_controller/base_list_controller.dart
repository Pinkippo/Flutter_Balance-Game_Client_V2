import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/list_controller/all_list_controller.dart';
import 'package:yangjataekil/controller/list_controller/theme_list_controller.dart';
import 'package:yangjataekil/controller/review_controller.dart';
import 'package:yangjataekil/data/model/board/board.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';
import 'package:yangjataekil/data/provider/game_repository.dart';
import 'package:yangjataekil/data/provider/list.repository.dart';
import 'package:yangjataekil/mixin/ReportMixin.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

abstract class BaseListController extends GetxController with ReportMixin {
  /// 페이지 당 게시글 수
  final Rx<int> size = 10.obs;

  /// 현재 페이지
  final Rx<int> page = 0.obs;

  /// 총 페이지 수
  final Rx<int> totalPage = 1.obs;

  /// 정렬 조건
  final Rx<SORTCONDITION?> sortCondition =
      Rx<SORTCONDITION?>(SORTCONDITION.LIKE);

  @override
  void onInit() {
    /// 신고 카테고리 초기화
    initializeCategories(REPORTCATEGORY.values);
    super.onInit();
  }

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

        refreshList();

        if (Get.currentRoute == '/game_detail') {
          Get.back();
        }
      }
    } catch (e) {
      print('게임 삭제 실패 (catch)');
      CustomSnackBar.showErrorSnackBar(message: "게임을 삭제할 수 없습니다.\n 다시 시도해주세요.");
    }
  }

  /// 리스트 새로고침
  Future<void> refreshList() async {
    // 각 컨트롤러가 초기화되어 있는지 확인 후 새로고침
    if (Get.isRegistered<AllListController>()) {
      AllListController.to.boards.clear();
      AllListController.to.page.value = 0;
      await AllListController.to.getList();
    }

    if (Get.isRegistered<ThemeListController>()) {
      ThemeListController.to.boards.clear();
      ThemeListController.to.page.value = 0;
      await ThemeListController.to.getList();
      await ThemeListController.to.getMyGames();
    }
  }

  /// 게임 신고
  @override
  Future<bool> reportGame(int boardId, String reason) async {
    reportReason.value =
        reason.isEmpty ? selectedCategory.value!.displayName : reason;

    try {
      final response = await GameRepository().reportGame(
        AuthController.to.accessToken.value,
        boardId,
        reportReason.value,
      );
      if (response) {
        print('(controller)게임 신고 성공');
        return true;
      } else {
        print('(controller)게임 신고 api조회 false');
        return false;
      }
    } catch (e) {
      print('(controller)게임 신고 api조회 오류');
      rethrow;
    }
  }

  /// 게임 차단
  Future<void> blockGame(int boardId) async {
    try {
      final response = await ListRepository()
          .blockGame(AuthController.to.accessToken.value, boardId);
      print('게임 차단 boardId: $boardId');

      // 팝업 닫기
      Get.back();

      if (response) {
        // 각 컨트롤러가 초기화되어 있는지 확인 후 새로고침
        if (Get.isRegistered<AllListController>()) {
          AllListController.to.boards.clear();
          AllListController.to.page.value = 0;
          await AllListController.to.getList();
        }

        if (Get.isRegistered<ThemeListController>()) {
          ThemeListController.to.boards.clear();
          ThemeListController.to.page.value = 0;
          await ThemeListController.to.getList();
        }

        if (Get.currentRoute == '/game_detail') {
          Get.back();
        }
      }
    } catch (e) {
      print('게임 삭제 실패 (catch)');
      CustomSnackBar.showErrorSnackBar(message: "게임을 삭제할 수 없습니다.\n 다시 시도해주세요.");
    }
  }

}
