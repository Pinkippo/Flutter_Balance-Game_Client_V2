import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/review_request_model.dart';
import 'package:yangjataekil/data/provider/review_repository.dart';

class GameReviewController extends GetxController {
  /// 좋아요
  final isLike = true.obs;

  /// 리뷰 제목
  final reviewTitle = ''.obs;

  /// 리뷰 내용
  final reviewContent = ''.obs;

  /// 리뷰 키워드
  final keyword = List<String>.empty(growable: true).obs;

  /// 키워드 추가
  void addKeyword(String value) {
    keyword.add(value);
    print('키워드 추가 >>> $value');
  }

  /// 좋아요 변경
  void changeLike(bool like) {
    isLike.value = like;
    print('좋아요: $isLike');
  }

  void updateReviewTitle(String value) {
    reviewTitle.value = value;
    print('리뷰 제목: $reviewTitle');
  }

  void updateReviewContent(String value) {
    reviewContent.value = value;
    print('리뷰 내용: $reviewContent');
  }

  /// 리뷰 업로드
  Future<void> uploadReview(int boardId) async {
    final reviewRequestModel = ReviewRequestModel(
        title: reviewTitle.value,
        comment: reviewContent.value,
        keywords: keyword,
        isLike: isLike.value,
        isDislike: !isLike.value);

    try {
      Get.dialog(AlertDialog(
        backgroundColor: Colors.white,
        title: Text('리뷰'),
        content: Text('리뷰를 작성하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              await ReviewRepository().uploadReview(
                  AuthController.to.accessToken.value,
                  boardId,
                  reviewRequestModel);
              print('리뷰 작성 완료: $reviewRequestModel');
              Get.back();
              Get.back();
              Get.snackbar(
                '리뷰 작성 성공',
                '리뷰가 작성이 완료되었습니다!',
                backgroundColor: Colors.black,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('확인'),
          ),
        ],
      ));
    } catch (e) {
      print('리뷰 작성 실패: $e');
    }
  }
}
