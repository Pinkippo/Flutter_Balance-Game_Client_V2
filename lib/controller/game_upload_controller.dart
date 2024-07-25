import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/provider/game_repository.dart';

import '../data/model/upload_game_request_model.dart';

class GameUploadController extends GetxController {
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

  /// 질문 추가
  void addQuestion() {
    boardContent.add(Question(
      questionTitle: '',
      questionItems: ['', ''],
    ));
    print('질문 추가');
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

  /// 게임 업로드
  Future<bool> uploadGame() async {
    if (gameTitle.value.isEmpty) {
      Get.snackbar(
        '미입력 항목',
        '게임 이름을 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (introduce.value.isEmpty) {
      Get.snackbar(
        '미입력 항목',
        '게임 소개를 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (keyword.isEmpty) {
      Get.snackbar(
        '미입력 항목',
        '키워드를 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (boardContent.isEmpty) {
      Get.snackbar(
        '미입력 항목',
        '질문을 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else {
      final bool uploadGameRequestModel = await GameRepository().uploadGame(
        UploadGameRequestModel(
            gameTitle: gameTitle.value,
            introduce: introduce.value,
            keyword: keyword,
            boardContent: boardContent),
        AuthController.to.accessToken.value,
      );
      print('게임 업로드 성공 >>> $uploadGameRequestModel');
      return true;
    }
  }
}
