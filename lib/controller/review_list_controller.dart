import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/review.dart';

import '../data/provider/review_list_repository.dart';

/// 리뷰 리스트 컨트롤러
class ReviewListController extends GetxController {
  /// 리뷰 리스트
  final reviews = <Review>[].obs;

  /// 게시글 ID
  final boardId = 0.obs;

  /// 게시글 ID를 받아오는 생성자
  ReviewListController(int boardId) {
    this.boardId.value = boardId;
  }

  @override
  void onInit() {
    getReviewList(boardId.value); // 리뷰 리스트 조회
    super.onInit();
  }

  /// 리뷰 리스트 조회 메서드
  Future<void> getReviewList(int boardId) async {
    try {
      final reviewList = await ReviewListRepository().getReviewList(
        AuthController.to.accessToken.value,
        boardId,
      );
      reviews.value = reviewList.reviews;
      print('리뷰 리스트 조회 성공 : ${reviews.toString()}');
    } catch (e) {
      print('리뷰 리스트 조회 실패 : $e');
    }
  }
}
