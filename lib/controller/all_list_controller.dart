import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/board/board.dart';
import '../data/model/board/list_board_request_model.dart';
import '../data/model/board/list_board_response_model.dart';
import '../data/provider/list.repository.dart';
import 'auth_controller.dart';


/// 전체 게임 리스트 컨트롤러
class AllListController extends GetxController {
  static AllListController get to => Get.find();

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
  final RxList<Board> allBoards = <Board>[].obs;

  /// 스크롤 컨트롤러
  final Rx<ScrollController> scrollController = ScrollController().obs;

  /// 정렬 조건 업데이트
  void updateSortCondition(SORTCONDITION condition) {
    if (sortCondition.value != condition) {
      sortCondition.value = condition;
      // 필터가 변경되면 리스트를 다시 로드
      allBoards.clear();
      page.value = 0;
      _getAllList();
    }
  }

  @override
  void onInit() {
    _getAllList();

    // 검색 스크롤 이벤트
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        _getAllList();
      }
    });
    super.onInit();
  }

  /// 리스트 호출 메서드
  Future<void> _getAllList() async {
    if (isLoading.value || page.value >= totalPage.value) return;

    isLoading.value = true; // 로딩 시작

    try {
      ListBoardResponseModel response = await ListRepository().getList(
        ListBoardRequestModel(
          searching: false,
          query: '',
          size: size.value,
          page: page.value,
          // themeId: ThemeListController.to.selectedThemeId.value,
          sortCondition: sortCondition.value,
        ),
        AuthController.to.accessToken.value,
      );
      allBoards.addAll(response.boards);
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
}
