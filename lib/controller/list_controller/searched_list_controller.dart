import 'package:get/get.dart';
import 'package:yangjataekil/controller/list_controller/base_list_controller.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

import '../../data/model/board/list_board_request_model.dart';
import '../../data/model/board/list_board_response_model.dart';
import '../../data/provider/list.repository.dart';
import '../auth_controller.dart';


/// 검색한 게임 결과 리스트 컨트롤러
class SearchedListController extends BaseListController {
  static SearchedListController get to => Get.find();

  /// 검색 텍스트
  final Rx<String> searchText = ''.obs;

  /// 검색 텍스트 업데이트
  void updateSearchText(String text) {
    searchText.value = text;
  }

  @override
  void onInit() {
    getList();

    // 검색 스크롤 이벤트
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent) {
        getList();
      }
    });
    super.onInit();
  }

  @override
  void updateSortCondition(SORTCONDITION condition) {
    if (sortCondition.value != condition) {
      sortCondition.value = condition;
      // 필터가 변경되면 리스트를 다시 로드
      boards.clear();
      page.value = 0;
      getList();
    }
  }

  /// 검색 리스트 호출 메서드
  @override
  Future<void> getList() async {
    if (isLoading.value || page.value >= totalPage.value) return;

    // 로딩 시작 상태로 설정
    isLoading.value = true;

    final ListBoardRequestModel requestModel;

    requestModel = ListBoardRequestModel(
      searching: true,
      query: searchText.value,
      size: size.value,
      page: page.value,
      // themeId: ThemeController.to.selectedThemeId.value,
      sortCondition: sortCondition.value,
    );

    try {
      // 딜레이 추가
      await Future.delayed(const Duration(seconds: 1));

      ListBoardResponseModel response = await ListRepository().getList(
        requestModel,
        AuthController.to.accessToken.value,
      );

      print('테마 id : ${requestModel.themeId}');
      boards.addAll(response.boards);
      totalPage.value = response.totalPage!; // totalPage 값 업데이트
      page.value += 1; // 페이지 값 증가
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(message: '게임 리스트를 가져오는 중 오류가 발생했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  /// 검색 버튼을 눌렀을 때 호출되는 메서드
  void clickSearchBtn() async {
    if (searchText.isEmpty) {
      boards.clear();
      CustomSnackBar.showSnackBar(message: '검색어를 입력해주세요.');
    } else {
      boards.clear(); // 이전 검색 결과 초기화
      page.value = 0; // 페이지 초기화
      totalPage.value = 1; // 총 페이지 수 초기화
      await getList(); // 검색 API 호출
    }
  }
}
