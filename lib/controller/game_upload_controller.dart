import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/tab/theme_controller.dart';
import 'package:yangjataekil/data/provider/game_repository.dart';
import 'package:yangjataekil/data/provider/theme_repository.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

import '../data/model/upload_game_request_model.dart';

class GameUploadController extends GetxController {
  // / 게임 테마 리스트
  // final RxList<String> gameTheme = <String>[].obs;
  //
//  / 게임 테마 index
  // final RxList<int> gameThemeIndex = <int>[].obs;

  /// 게임 테마, index
  final RxMap<String, int> themeNameIndexMap = RxMap();

  /// 선택된 게임 테마 index
  final RxInt selectedGameThemeIndex = 0.obs;

  /// 게임 이름
  final gameTitle = ''.obs;

  /// 게임 소개
  final introduce = ''.obs;

  /// 키워드
  final keyword = List<String>.empty(growable: true).obs;

  /// 게임 내용
  final boardContent = List<Question>.empty(growable: true).obs;

  /// 스크롤 컨트롤러
  final scrollController = ScrollController();

  /// 게임 이름 업데이트
  void updateGameName(String value) {
    gameTitle.value = value;
  }

  /// 게임 소개 업데이트
  void uploadIntroduce(String value) {
    introduce.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    // 기본 질문 두 개 추가
    boardContent.addAll([
      Question(questionTitle: '', questionItems: ['', '']),
    ]);
    getTheme();
  }

  /// 질문 추가
  void addQuestion() {
    boardContent.add(Question(
      questionTitle: '',
      questionItems: ['', ''],
    ));
    print('질문 추가');
  }

  /// 질문 삭제
  void removeQuestion(int index) {
    boardContent.removeAt(index);
    print('${index + 1}번 질문삭제');
  }

  /// 질문 제목 업데이트
  void updateQuestionTitle(int index, String questionTitle) {
    boardContent[index].questionTitle = questionTitle;
    print('질문 제목 업데이트 >>> $questionTitle');
  }

  /// 답변 업데이트
  void updateAnswer(int index, int answerIndex, String answerText) {
    boardContent[index].questionItems[answerIndex] = answerText;
    print('$index번째질문 ${answerIndex + 1}번째 답변 업데이트 >>> $answerText');
  }

  /// 키워드 추가
  void addKeyword(String value) {
    keyword.add(value);
    print('키워드 추가 >>> $value');
  }

  /// 스크롤을 하단으로 이동
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 60), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// 테마 조회 및 이름, index 설정
  Future<void> getTheme() async {
    final themes = await ThemeRepository().getList();
    for (var theme in themes.themes) {
      themeNameIndexMap[theme.theme] = theme.themeId;
    }
    print('테마 조회 성공 : ${themeNameIndexMap}');
  }

  /// 게임 업로드
  Future<void> uploadGame() async {
    if (selectedGameThemeIndex.value == 0) {
      CustomSnackBar.showErrorSnackBar(
          title: '게임 테마', message: '게임 테마를 선택해주세요.');
      return;
    } else if (gameTitle.value.isEmpty) {
      CustomSnackBar.showErrorSnackBar(
          title: '게임 이름', message: '게임 이름을 입력해주세요.');
      return;
    } else if (introduce.value.isEmpty) {
      CustomSnackBar.showErrorSnackBar(
          title: '게임 소개', message: '게임 소개를 입력해주세요.');
      return;
    } else if (boardContent.any(
        (element) => element.questionItems.any((element) => element.isEmpty))) {
      CustomSnackBar.showErrorSnackBar(
          title: '답변 입력', message: '답변을 모두 입력해주세요.');
      return;
    } else {
      final uploadResult = await GameRepository().uploadGame(
        UploadGameRequestModel(
            themeId: selectedGameThemeIndex.value,
            gameTitle: gameTitle.value,
            introduce: introduce.value,
            keyword: keyword,
            boardContent: boardContent),
        AuthController.to.accessToken.value,
      );
      if (uploadResult) {
        Get.offAllNamed('/main');
        CustomSnackBar.showSuccessSnackBar(
            title: '게임 생성', message: '게임이 성공적으로 업로드되었습니다.');
      } else {
        CustomSnackBar.showErrorSnackBar(
            title: '게임 생성 실패', message: '게임 업로드에 실패했습니다.');
        return;
      }
    }
  }
}
