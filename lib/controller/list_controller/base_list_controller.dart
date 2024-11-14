import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/board/board.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';
import 'package:yangjataekil/data/provider/list.repository.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';


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
  Future<void> getList({bool isRefresh = false});

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

  /// 정렬 조건 업데이트
  void updateSortCondition(SORTCONDITION condition);

  /// 내가 쓴 게임 삭제
  Future<void> deleteMyGame(int boardId) async {
    try {
      final response = await ListRepository().deleteMyGame(AuthController.to.accessToken.value, boardId);
      print('게임 삭제 boardId: $boardId');

      // 팝업 닫기
      Get.back();

      if(response) {
        print('게임 삭제 성공');

        final currentRoute = Get.currentRoute;
        if(currentRoute == '/my_games') {
          await getMyGames(); // 내가 쓴 게임 리스트 다시 불러오기
        } else {
          // 리스트 초기화 후 다시 불러오기
          boards.clear();
          page.value = 0;
          await getList();
        }
        update(); // 화면 갱신

        CustomSnackBar.showSuccessSnackBar(title: "게임 삭제 성공", message: "게임 삭제가 완료되었습니다.");
      } else {
        print('게임 삭제 실패');
        CustomSnackBar.showErrorSnackBar(message: "게임을 삭제할 수 없습니다.\n 다시 시도해주세요.");
      }
    } catch(e) {
      print('게임 삭제 실패 (catch)');
      CustomSnackBar.showErrorSnackBar(message: "게임을 삭제할 수 없습니다.\n 다시 시도해주세요.");
    }
  }
}