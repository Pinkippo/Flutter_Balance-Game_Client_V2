import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/list_controller/all_list_controller.dart';
import 'package:yangjataekil/data/model/review.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';
import '../data/provider/review_repository.dart';

/// 신고 카테고리
enum REPORTCATEGORY {
  abusiveLanguage, // 욕설
  falseInformation, // 허위사실
  advertising, // 광고성
  spam, // 스팸
  personalInformationExposure, // 개인정보노출
  others, // 기타
}

/// 신고 카테고리 확장 - 문자열 반환
extension ReportCategoryExtension on REPORTCATEGORY {
  String get displayName {
    switch (this) {
      case REPORTCATEGORY.abusiveLanguage:
        return "욕설";
      case REPORTCATEGORY.falseInformation:
        return "허위사실";
      case REPORTCATEGORY.advertising:
        return "광고성";
      case REPORTCATEGORY.spam:
        return "스팸";
      case REPORTCATEGORY.personalInformationExposure:
        return "개인정보노출";
      case REPORTCATEGORY.others:
        return "기타";
    }
  }
}

/// 리뷰 리스트 컨트롤러
class ReviewController extends GetxController {
  final reviews = [].obs; // 리뷰 리스트
  final myReviews = [].obs; // 내가 작성한 리뷰

  /// 게시글 ID
  final boardId = 0.obs;

  /// 리뷰 리스트 조회 메서드
  Future<void> getReviewList(int boardId) async {
    try {
      final reviewList = await ReviewRepository().getReviewList(
        AuthController.to.accessToken.value,
        boardId,
      );
      reviews.clear();
      reviews.value = reviewList.reviews;
      print('리뷰 리스트 조회 성공 : ${reviews.toString()}');
    } catch (e) {
      print('리뷰 리스트 조회 실패 : $e');
      CustomSnackBar.showErrorSnackBar(message: '리뷰 리스트 조회 실패');
    }
  }

  /// 내가 작성한 리뷰 리스트 조회
  Future<void> getMyReviewList() async {
    try {
      final myReviewList = await ReviewRepository().getMyReviewList(
        AuthController.to.accessToken.value,
      );

      myReviews.value = myReviewList.reviews;
    } catch (e) {
      print('내가 작성한 리뷰 리스트 조회 실패 : $e');
      CustomSnackBar.showErrorSnackBar(message: '내가 작성한 리뷰 리스트 조회 실패');
    }
  }

  /// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 리뷰 신고 파트 변수 및 메서드 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

  /// 게시물의 각 리뷰 ID
  final boardReviewId = 0.obs;

  /// 신고 내용
  final reportReason = ''.obs;

  /// 카테고리
  final categories = REPORTCATEGORY.values;

  /// 선택된 신고 카테고리
  final selectedCategory = Rx<REPORTCATEGORY?>(null);

  /// 카테고리 선택 메서드
  void toggleCategory(REPORTCATEGORY category) {
    selectedCategory.value = category;
  }

  /// 신고 내용 업데이트
  void updateContent(String value) {
    reportReason.value = value;
  }

  /// 리뷰 신고 메서드
  Future<bool> reportReview(
      int boardId, int reviewId, String reviewContent) async {
    boardReviewId.value = reviewId;
    reportReason.value = reviewContent.isEmpty
        ? selectedCategory.value!.displayName
        : reviewContent;

    try {
      final response = await ReviewRepository().reportReview(
          AuthController.to.accessToken.value,
          boardId,
          boardReviewId.value,
          reportReason.value);
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

  /// 리뷰 차단
  Future<void> blockReview(int boardReviewId, int boardId) async {
    print('리뷰 차단 boardReviewId: $boardReviewId');
    print('리뷰 차단 boardId: $boardId');

    try {
      final response = await ReviewRepository().blockReview(
        AuthController.to.accessToken.value,
        boardReviewId,
        boardId,
      );
      AllListController().refreshList();

      // 팝업 닫기
      Get.back();
      if (response) {
        CustomSnackBar.showSuccessSnackBar(message: '리뷰가 차단되었습니다.');
        getReviewList(boardId);
      } else {
        print('리뷰 차단 실패');
        CustomSnackBar.showErrorSnackBar(
            message: '리뷰를 차단할 수 없습니다.\n 다시 시도해주세요.');
      }
    } catch (e) {
      print('리뷰 차단 실패 (catch)');
      CustomSnackBar.showErrorSnackBar(message: "리뷰를 차단할 수 없습니다.\n 다시 시도해주세요.");
    }
  }

  /// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
}
