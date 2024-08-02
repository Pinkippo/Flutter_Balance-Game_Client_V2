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
  final Rx<int> size = 10.obs;
  final Rx<int> page = 0.obs;
  final RxBool isLoading = false.obs;
  final Rx<SORTCONDITION?> sortCondition = Rx<SORTCONDITION?>(null);
  final RxList<Board> boards = <Board>[].obs;
  final Rx<int> totalPage = 1.obs;

  var scrollController = ScrollController().obs;

  @override
  void onInit() {
    _getList();

    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        _getList();
      }
    });

    super.onInit();
  }

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

    isLoading.value = true;  // 로딩 시작

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
      page.value += 1;  // 페이지 값 증가
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
