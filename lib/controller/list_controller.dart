import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/tab/theme_list_controller.dart';
import 'package:yangjataekil/data/model/board/board.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';
import 'package:yangjataekil/data/model/board/list_board_response_model.dart';
import 'package:yangjataekil/data/provider/list.repository.dart';

enum SORTCONDITION { LIKE, DATE }

class ListController extends GetxController {
  /// 페이지 당 게시글 수
  final Rx<int> size = 10.obs;

  /// 현재 페이지
  final Rx<int> page = 0.obs;

  /// 로딩 상태
  final RxBool isLoading = false.obs;

  /// 정렬 조건
  final Rx<SORTCONDITION?> sortCondition = Rx<SORTCONDITION?>(null);

  /// 게시판 리스트
  final RxList<Board> boards = <Board>[].obs;

  /// 총 페이지 수
  final Rx<int> totalPage = 1.obs;

  /// 스크롤 컨트롤러
  final Rx<ScrollController> scrollController = ScrollController().obs;

  /// 검색 결과 리스트
  final RxList<Board> filteredGames = <Board>[].obs;

  /// 검색 텍스트
  final Rx<String> searchText = ''.obs;

  @override
  void onInit() {
    // 리스트 호출
    _getList();

    // 스크롤 이벤트
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        _getList();
      }
    });

    // 검색 텍스트가 변경되면 필터링
    ever(searchText, (_) {
      filterBoards();
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

  /// 검색 텍스트로 리스트 필터링
  void filterBoards() {
    if (searchText.isEmpty) {
      filteredGames.assignAll(boards);
    } else {
      filteredGames.assignAll(boards.where((board) {
        return board.title.contains(searchText.value) ||
            board.introduce.contains(searchText.value) ||
            board.keywords.any((keyword) => keyword.contains(searchText.value));
      }).toList());
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
          size: size.value,
          page: page.value,
          themeId: ThemeListController.to.selectedThemeId.value,
          sortCondition: sortCondition.value,
        ),
        AuthController.to.accessToken.value,
      );
      boards.addAll(response.boards);
      totalPage.value = response.totalPage; // totalPage 값 업데이트
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
