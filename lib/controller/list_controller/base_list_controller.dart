import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/model/board/board.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';


abstract class BaseListController extends GetxController {
  /// 페이지 당 게시글 수
  final Rx<int> size = 10.obs;

  /// 현재 페이지
  final Rx<int> page = 0.obs;

  /// 총 페이지 수
  final Rx<int> totalPage = 1.obs;

  /// 정렬 조건
  final Rx<SORTCONDITION?> sortCondition = Rx<SORTCONDITION?>(SORTCONDITION.LIKE);

  /// 로딩 상태
  final RxBool isLoading = false.obs;

  /// 게임 리스트
  final RxList<Board> boards = <Board>[].obs;
  final RxList<Board> myBoards = <Board>[].obs; // 내가 쓴 게임 리스트
  final RxList<Board> participatedBoards = <Board>[].obs; // 참여한 게임 리스트

  /// 스크롤 컨트롤러
  final Rx<ScrollController> scrollController = ScrollController().obs;

  /// 게임 리스트 가져오기
  Future<void> getList();

  /// 정렬 조건 업데이트
  void updateSortCondition(SORTCONDITION condition);

}