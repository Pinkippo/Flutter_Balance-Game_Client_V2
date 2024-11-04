import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/review.dart';
import 'package:yangjataekil/data/provider/review_repository.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

import '../data/provider/list.repository.dart';

class RecommendController extends GetxController {
  static RecommendController get to => Get.find();

  final RxInt recommendGameId = 0.obs;

  void getRecommendId(int id) {
    recommendGameId.value = id;
    print('선택된 게임 boardId: $recommendGameId');
  }

  final recommendedReviews = [].obs; // 추천 리뷰

  @override
  void onInit() {
    super.onInit();
    getRecommendedReviews();
  }

  /// 오늘의 추천 게시글 호출 메서드
  Future<int> getRecommendList() async {
    try {
      final response = await ListRepository()
          .getRecommendList(AuthController.to.accessToken.value);
      print('오늘의 추천 게시글: ${response.boardId}');
      return response.boardId;
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(
          title: '오늘의 추천 게시글 조회 실패', message: '다시 시도해주세요.');
      return -1;
    }
  }

  /// getRecommendList의 결과를 getRecommendId에 넘기는 메서드
  Future<void> setRecommendGameId() async {
    final boardId = await getRecommendList(); // getRecommendList 호출
    if (boardId != -1) {
      // 오류가 없을 때만 getRecommendId 호출
      getRecommendId(boardId);
    } else {
      getRecommendId(-1);
    }
  }

  /// 추천 리뷰 리스트 조회
  Future<void> getRecommendedReviews() async {
    try {
      final reviewList = await ReviewRepository().getRecommendedReviews();
      recommendedReviews.value = reviewList.reviews;
      print('추천 리뷰 조회 성공 : ${recommendedReviews.toString()}');
    } catch (e) {
      print('추천 리뷰 조회 실패 : $e');
      CustomSnackBar.showErrorSnackBar(
          title: '추천 리뷰 조회 실패', message: '다시 시도해주세요.');
      print('추천 리뷰 조회 실패 controller');
      throw Exception('추천 리뷰 조회 실패 controller');
    }
  }
}
