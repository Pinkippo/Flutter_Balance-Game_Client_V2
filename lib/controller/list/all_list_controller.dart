import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/list/base_list_controller.dart';
import 'package:yangjataekil/mixin/ReportMixin.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

import '../../data/model/board/list_board_request_model.dart';
import '../../data/model/board/list_board_response_model.dart';
import '../../data/repository/list.repository.dart';
import '../auth/auth_controller.dart';

/// 전체 게임 리스트 컨트롤러
class AllListController extends BaseListController with ReportMixin {
  static AllListController get to => Get.find();

  @override
  void onInit() {
    getList();

    // 검색 스크롤 이벤트
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        getList();
      }
    });
    super.onInit();
  }

  /// 리스트 호출 메서드
  @override
  Future<void> getList({bool isRefresh = false}) async {
    print('alllistcontroller getList');
    if (isLoading.value || page.value >= totalPage.value) return;

    isLoading.value = true; // 로딩 시작

    if (isRefresh) {
      boards.clear();
      page.value = 0;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    try {
      ListBoardResponseModel response = await ListRepository().getList(
        ListBoardRequestModel(
          searching: false,
          size: size.value,
          page: page.value,
          sortCondition: sortCondition.value,
          themeId: null,
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

  /// 정렬 조건 업데이트
  @override
  void updateSortCondition(SORTCONDITION condition) {
    if (sortCondition.value != condition) {
      sortCondition.value = condition;
      // 필터가 변경되면 리스트를 다시 로드
      boards.clear();
      page.value = 0;
      totalPage.value = 1;
      getList();
    }
  }

  @override
  Future<void> deleteMyGame(int boardId) {
  //   TODO: implement deleteMyGame
    return super.deleteMyGame(boardId);
  }

  @override
  Future<bool> reportGame(int boardId, String reason) async {
    // AllListController에서의 커스텀 로직
    print('AllListController에서 게임 신고 로직 실행');
    return super.reportGame(boardId, reason);
  }
}
