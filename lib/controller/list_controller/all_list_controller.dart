import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/list_controller/base_list_controller.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

import '../../data/model/board/board.dart';
import '../../data/model/board/list_board_request_model.dart';
import '../../data/model/board/list_board_response_model.dart';
import '../../data/provider/list.repository.dart';
import '../auth_controller.dart';


/// 전체 게임 리스트 컨트롤러
class AllListController extends BaseListController {
  static AllListController get to => Get.find();

  /// 페이지 당 게시글 수
  get getSize => size.value;

  /// 현재 페이지
  get getPage => page.value;

  /// 총 페이지 수
  get getTotalPage => totalPage.value;

  /// 정렬 조건
  get getSortCondition => sortCondition.value;

  /// 로딩 상태
  get getIsLoading => isLoading.value;

  /// 전체 게임 리스트
  get getBoards => boards;

  /// 스크롤 컨트롤러
  get getScrollController => scrollController.value;


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
  Future<void> getList() async {
    if (isLoading.value || page.value >= totalPage.value) return;

    isLoading.value = true; // 로딩 시작

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
      /// TODO: 게임 리스트 가져올 때 중복으로 가져오는 문제 해결해야함
      // print('page: ${page.value} totalPage: ${response.totalPage}');
      //
      // boards.addAll(response.boards.where((newBoard) =>
      // !boards.any((existingBoard) => existingBoard.boardId == newBoard.boardId)
      // ));
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

}
