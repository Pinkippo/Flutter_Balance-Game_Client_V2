import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/provider/list.repository.dart';

class RecommendController extends GetxController {
  static RecommendController get to => Get.find();

  final RxInt recommendGameId = 0.obs;

  void getRecommendId(int id) {
    recommendGameId.value = id;
    print('선택된 게임 boardId: $recommendGameId');
  }

  /// 오늘의 추천 게시글 호출 메서드
  Future<int> getRecommendList() async {
    try {
      final response = await ListRepository().getRecommendList();
      print('오늘의 추천 게시글: ${response.boardId}');
      return response.boardId;
    } catch (e) {
      Get.snackbar(
        '오류',
        '오늘의 추천 게시글을 가져오는 중 오류가 발생했습니다: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return -1;
    }
  }

  /// getRecommendList의 결과를 getRecommendId에 넘기는 메서드
  Future<void> setRecommendGameId() async {
    final boardId = await getRecommendList(); // getRecommendList 호출
    if (boardId != -1) {
      // 오류가 없을 때만 getRecommendId 호출
      getRecommendId(boardId);
    }
  }
}
