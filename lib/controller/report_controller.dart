import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/provider/report_repository.dart';

/// 신고 컨트롤러
class ReportController extends GetxController {

  /// 컨트롤러 접근을 위한 getter
  static ReportController get to => Get.find();

  /// 게시물 리뷰 ID
  final boardReviewId = 0.obs;

  /// 신고 내용
  final content = ''.obs;

  late final selectedCategories = ''.obs;

  final categories = [
    "욕설",
    "허위사실",
    "광고성",
    "스팸",
    "개인정보노출",
    "기타"
  ].obs;

  void toggleCategory(String category) {
    selectedCategories.value = category;
  }

  bool isSelected(String category) {
    return selectedCategories.contains(category);
  }


  /// 신고 내용 업데이트
  void updateContent(String value) {
    content.value = value;
    print('신고 내용: ${content.value}');
  }

  /// 리뷰 신고 메서드
  Future<bool> reviewReport(int reviewId, String reviewContent) async {
    boardReviewId.value = reviewId;
    content.value = reviewContent;

    try {
      final response = await ReportRepository()
          .reviewReport(AuthController.to.accessToken.value, boardReviewId.value, content.value);
      if (response) {
        print('(controller)리뷰 신고 성공');
        return true;
      } else {
        print('(controller)리뷰 신고 api조회 false');
        return false;
      }
    } on HttpException catch (e) {
      print('(controller)리뷰 신고 실패 - Http 예외: $e');
      rethrow;
      // 필요시 사용자에게 오류 메시지를 표시할 수 있습니다.
    } catch (e) {
      print('(controller)리뷰 신고 api 받아오기 실패: $e');
      rethrow;
    }
  }
}
