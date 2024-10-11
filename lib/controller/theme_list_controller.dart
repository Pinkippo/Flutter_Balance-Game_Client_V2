import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/tab/theme_controller.dart';
import 'package:yangjataekil/data/model/board/board.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';
import 'package:yangjataekil/data/model/board/list_board_response_model.dart';
import 'package:yangjataekil/data/provider/list.repository.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';


/// 테마별 게임 리스트 컨트롤러
class ThemeListController extends GetxController {
  /// .to로 생성된 인스턴스에 접근하기 위한 static 변수
  static ThemeListController get to => Get.find();

  /// 페이지 당 게시글 수
  final Rx<int> size = 10.obs;

  /// 현재 페이지
  final Rx<int> page = 0.obs;

  /// 총 페이지 수
  final Rx<int> totalPage = 1.obs;

  /// 정렬 조건
  final Rx<SORTCONDITION?> sortCondition = Rx<SORTCONDITION?>(null);

  /// 로딩 상태
  final RxBool isLoading = false.obs;

  final RxList<Board> boards = <Board>[].obs; // 게임 리스트
  final RxList<Board> myBoards = <Board>[].obs; // 내가 쓴 게임 리스트
  final RxList<Board> participatedBoards = <Board>[].obs; // 참여한 게임 리스트

  /// 스크롤 컨트롤러
  final Rx<ScrollController> scrollController = ScrollController().obs;

  /// 검색 스크롤 컨트롤러
  final Rx<ScrollController> searchScrollController = ScrollController().obs;

  @override
  void onInit() async {
    if(Get.currentRoute == '/my_games') {
      print('현재 라우트: ${Get.currentRoute}');
      await getMyGames();
    } else if(Get.currentRoute == '/participated_games') {
      print('현재 라우트: ${Get.currentRoute}');
      await getParticipatedGames();
    } else {
      await _getList();
    }

    // 스크롤 이벤트
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        _getList();
      }
    });

    super.onInit();
  }

  /// 정렬 조건 업데이트
  void updateSortCondition(SORTCONDITION condition) {
    if (sortCondition.value != condition) {
      sortCondition.value = condition;
      // 필터가 변경되면 리스트를 다시 로드
      boards.clear();
      page.value = 0;
      _getList();
    }
  }

  /// 리스트 호출 메서드
  Future<void> _getList() async {
    if (isLoading.value || page.value >= totalPage.value) return;

    isLoading.value = true; // 로딩 시작

    try {
      ListBoardResponseModel response = await ListRepository().getList(
        ListBoardRequestModel(
          searching: false,
          query: '',
          size: size.value,
          page: page.value,
          themeId: ThemeController.to.selectedThemeId.value,
          sortCondition: sortCondition.value,
        ),
        AuthController.to.accessToken.value,
      );
      boards.addAll(response.boards);
      totalPage.value = response.totalPage!; // totalPage 값 업데이트
      page.value += 1; // 페이지 값 증가
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(message: '게임 리스트를 가져오는 중 오류가 발생했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  /// 내가 쓴 게임 리스트 호출 메서드
  Future<void> getMyGames() async {
    try {
      final response = await ListRepository()
          .getMyGames(AuthController.to.accessToken.value);
      print('내가 쓴 게임 리스트: ${response.boards}');

      // 내가 쓴 게임 리스트 초기화 후 새로운 값으로 업데이트
      myBoards.clear();
      myBoards.addAll(response.boards);
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(message: '내 게임 리스트를 가져오는 중 오류가 발생했습니다.');
    }
  }

  /// 참여한 게임 리스트 호출 메서드
  Future<void> getParticipatedGames() async {
    try {
      final response = await ListRepository()
          .getParticipatedGames(AuthController.to.accessToken.value);
      print('참여한 게임 리스트: ${response.boards}');

      // 참여한 게임 리스트 초기화 후 새로운 값으로 업데이트
      participatedBoards.clear();
      participatedBoards.addAll(response.boards);
    } catch (e) {
      printError(info: '참여한 게임 리스트 호출 오류: $e');
      CustomSnackBar.showErrorSnackBar(message: '참여한 게임 리스트를 가져오는 중 오류가 발생했습니다.');
    }
  }

}
