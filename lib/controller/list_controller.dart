import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/tab/theme_list_controller.dart';
import 'package:yangjataekil/data/model/board/board.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';
import 'package:yangjataekil/data/model/board/list_board_response_model.dart';
import 'package:yangjataekil/data/provider/list.repository.dart';

enum SORTCONDITION { LIKE, DATE }

class ListController extends GetxController {
  /// .to로 생성된 인스턴스에 접근하기 위한 static 변수
  static ListController get to => Get.find();

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

  /// 게임 리스트
  final RxList<Board> boards = <Board>[].obs;

  /// 내가 쓴 게임 리스트
  final RxList<Board> myBoards = <Board>[].obs;

  /// 검색 결과 리스트
  final RxList<Board> filteredGames = <Board>[].obs;

  /// 검색 텍스트
  final Rx<String> searchText = ''.obs;

  /// 스크롤 컨트롤러
  final Rx<ScrollController> scrollController = ScrollController().obs;

  /// 검색 스크롤 컨트롤러
  final Rx<ScrollController> searchScrollController = ScrollController().obs;

  @override
  void onInit() async {
    // 내 게임 리스트 페이지를 제외한 다른 페이지에서는 게임 리스트를 가져옴
    if (Get.currentRoute != '/my_games') {
      print('현재 라우트: ${Get.currentRoute}');
      await _getList();
    } else {
      print('현재 라우트: ${Get.currentRoute}');
      await getMyGames();
    }

    // 스크롤 이벤트
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        _getList();
      }
    });

    // 검색 스크롤 이벤트
    searchScrollController.value.addListener(() {
      if (searchScrollController.value.position.pixels ==
          searchScrollController.value.position.maxScrollExtent) {
        _getSearchedList();
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

  /// 검색 텍스트 업데이트
  void updateSearchText(String text) {
    searchText.value = text;
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
          themeId: ThemeListController.to.selectedThemeId.value,
          sortCondition: sortCondition.value,
        ),
        AuthController.to.accessToken.value,
      );
      boards.addAll(response.boards);
      totalPage.value = response.totalPage!; // totalPage 값 업데이트
      page.value += 1; // 페이지 값 증가
    } catch (e) {
      Get.snackbar(
        '오류',
        '리스트를 가져오는 중 오류가 발생했습니다: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// 검색 리스트 호출 메서드
  Future<void> _getSearchedList() async {
    if (isLoading.value || page.value >= totalPage.value) return;

    // 로딩 시작 상태로 설정
    isLoading.value = true;

    try {
      // 딜레이 추가
      await Future.delayed(const Duration(seconds: 1));

      ListBoardResponseModel response = await ListRepository().getList(
        ListBoardRequestModel(
          searching: true,
          query: searchText.value,
          size: size.value,
          page: page.value,
          themeId: ThemeListController.to.selectedThemeId.value,
          sortCondition: sortCondition.value,
        ),
        AuthController.to.accessToken.value,
      );

      filteredGames.addAll(response.boards);
      totalPage.value = response.totalPage!; // totalPage 값 업데이트
      page.value += 1; // 페이지 값 증가
    } catch (e) {
      Get.snackbar(
        '오류',
        '리스트를 가져오는 중 오류가 발생했습니다: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// 검색 버튼을 눌렀을 때 호출되는 메서드
  void clickSearchBtn() async {
    if (searchText.isEmpty) {
      filteredGames.clear();
      Get.snackbar(
        '검색어를 입력해주세요',
        '검색어를 입력하지 않으면 검색할 수 없습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      filteredGames.clear(); // 이전 검색 결과 초기화
      page.value = 0; // 페이지 초기화
      totalPage.value = 1; // 총 페이지 수 초기화
      await _getSearchedList(); // 검색 API 호출
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
      Get.snackbar(
        '오류',
        '내가 쓴 게임 리스트를 가져오는 중 오류가 발생했습니다: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
