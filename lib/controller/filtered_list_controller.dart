import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/tab/theme_controller.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

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

  /// 검색 리스트 전체/테마 여부
  final bool isAllList;

  /// 생성자
  FilteredListController({required this.isAllList});

  @override
  void onInit() {
    // 스크롤 이벤트
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        _getSearchedList(isAllList);
      }
    });
    super.onInit();
  }

  /// 검색 텍스트 업데이트
  void updateSearchText(String text) {
    searchText.value = text;
  }

  /// 정렬 조건 업데이트
  void updateSortCondition(SORTCONDITION condition, bool isAllList) {
    if (sortCondition.value != condition) {
      sortCondition.value = condition;
      // 필터가 변경되면 리스트를 다시 로드
      filteredList.clear();
      page.value = 0;
      _getSearchedList(isAllList);
    }
  }

  /// 검색 리스트 호출 메서드
  Future<void> _getSearchedList(bool isAllList) async {
    if (isLoading.value || page.value >= totalPage.value) return;

    // 로딩 시작 상태로 설정
    isLoading.value = true;

    final ListBoardRequestModel requestModel;

    if (isAllList) {
      requestModel = ListBoardRequestModel(
        searching: true,
        query: searchText.value,
        size: size.value,
        page: page.value,
        sortCondition: sortCondition.value,
      );
    } else {
      requestModel = ListBoardRequestModel(
        searching: true,
        query: searchText.value,
        size: size.value,
        page: page.value,
        themeId: ThemeController.to.selectedThemeId.value,
        sortCondition: sortCondition.value,
      );
    }
    try {
      // 딜레이 추가
      await Future.delayed(const Duration(seconds: 1));

      ListBoardResponseModel response = await ListRepository().getList(
        requestModel,
        AuthController.to.accessToken.value,
      );

      print('테마 id : ${requestModel.themeId}');
      filteredList.addAll(response.boards);
      totalPage.value = response.totalPage!; // totalPage 값 업데이트
      page.value += 1; // 페이지 값 증가
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(message: '게임 리스트를 가져오는 중 오류가 발생했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  /// 검색 버튼을 눌렀을 때 호출되는 메서드
  void clickSearchBtn(bool isAllList) async {
    if (searchText.isEmpty) {
      filteredList.clear();
      CustomSnackBar.showSnackBar(message: '검색어를 입력해주세요.');
    } else {
      filteredList.clear(); // 이전 검색 결과 초기화
      page.value = 0; // 페이지 초기화
      totalPage.value = 1; // 총 페이지 수 초기화
      await _getSearchedList(isAllList); // 검색 API 호출
    }
  }
}
