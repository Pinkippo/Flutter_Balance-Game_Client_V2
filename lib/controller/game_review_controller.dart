import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/review_request_model.dart';
import 'package:yangjataekil/data/provider/review_repository.dart';
import 'package:yangjataekil/utils/text_util.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

class GameReviewController extends GetxController {
  /// 좋아요
  final isLike = true.obs;

  /// 리뷰 제목
  final reviewTitle = ''.obs;

  /// 리뷰 내용
  final reviewContent = ''.obs;

  /// 리뷰 키워드
  final keywordList = List<String>.empty(growable: true).obs;

  /// 키워드 추가
  void addKeyword(String value) {
    keywordList.add(value);
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
    // title, comment는 필수 입력
    if (reviewTitle.value.isEmpty || reviewContent.value.isEmpty) {
      CustomSnackBar.showErrorSnackBar(
        title: '리뷰 작성 실패',
        message: '리뷰 제목과 내용을 입력해주세요.',
      );
      return;
    }

    final reviewRequestModel = ReviewRequestModel(
        title: reviewTitle.value,
        comment: reviewContent.value,
        keywords: keywordList,
        isLike: isLike.value,
        isDislike: !isLike.value);

    try {
      Get.dialog(
        AlertDialog(
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
                final response = await ReviewRepository().uploadReview(
                    AuthController.to.accessToken.value,
                    boardId,
                    reviewRequestModel);
                Get.back();
                if (response) {
                  print('리뷰 작성 완료: $reviewRequestModel');
                  Get.back();
                  CustomSnackBar.showSuccessSnackBar(
                    title: '리뷰 작성 성공',
                    message: '리뷰가 작성이 완료되었습니다!',
                  );
                } else {
                  print('리뷰 작성 실패: $reviewRequestModel');
                  CustomSnackBar.showErrorSnackBar(
                    title: '리뷰 작성 실패',
                    message: '리뷰 작성에 실패했습니다.',
                  );
                }
              },
              child: Text('확인'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('리뷰 작성 실패: $e');
    }
  }

  /// 비속어 필터링
  Future<bool> checkProfanity() async {
    TextUtil textUtil = TextUtil();
    if (await textUtil.textFiltering(reviewTitle.value)) return false;
    if (await textUtil.textFiltering(reviewContent.value)) return false;
    for (var keyword in keywordList) {
      if (await textUtil.textFiltering(keyword)) return false;
    }

    return true;
  }
}
