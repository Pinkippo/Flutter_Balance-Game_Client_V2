import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
      questionItems: ['',''],
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
}
