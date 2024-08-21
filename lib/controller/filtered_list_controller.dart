import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/tab/theme_controller.dart';

import '../data/model/board/board.dart';
import '../data/model/board/list_board_request_model.dart';
import '../data/model/board/list_board_response_model.dart';
import '../data/provider/list.repository.dart';
import 'all_list_controller.dart';
import 'auth_controller.dart';

// enum SORTCONDITION { LIKE, DATE }

/// 검색한 게임 결과 리스트 컨트롤러
class FilteredListController extends GetxController {
  static FilteredListController get to => Get.find();

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
  final RxList<Board> filteredList = <Board>[].obs;

  /// 검색 텍스트
  final Rx<String> searchText = ''.obs;

  /// 스크롤 컨트롤러
  final Rx<ScrollController> scrollController = ScrollController().obs;

  @override
  void onInit() {
    // 스크롤 이벤트
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        _getSearchedList();
      }
    });
    super.onInit();
  }

  /// 검색 텍스트 업데이트
  void updateSearchText(String text) {
    searchText.value = text;
  }

  /// 정렬 조건 업데이트
  void updateSortCondition(SORTCONDITION condition) {
    if (sortCondition.value != condition) {
      sortCondition.value = condition;
      // 필터가 변경되면 리스트를 다시 로드
      filteredList.clear();
      page.value = 0;
      _getSearchedList();
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
          themeId: ThemeController.to.selectedThemeId.value,
          sortCondition: sortCondition.value,
        ),
        AuthController.to.accessToken.value,
      );

      filteredList.addAll(response.boards);
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
      filteredList.clear();
      Get.snackbar(
        '검색어를 입력해주세요',
        '검색어를 입력하지 않으면 검색할 수 없습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      filteredList.clear(); // 이전 검색 결과 초기화
      page.value = 0; // 페이지 초기화
      totalPage.value = 1; // 총 페이지 수 초기화
      await _getSearchedList(); // 검색 API 호출
    }
  }
}
