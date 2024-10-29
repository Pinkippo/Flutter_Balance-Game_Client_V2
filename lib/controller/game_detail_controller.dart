import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/review_controller.dart';
import 'package:yangjataekil/data/model/game/game_detail_response_model.dart';
import 'package:yangjataekil/data/model/game/game_detail_writer.dart';
import 'package:yangjataekil/data/model/game/related_game_model.dart';
import 'package:yangjataekil/data/provider/game_repository.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

class GameDetailController extends GetxController {
  /// 스크롤 컨트롤러
  final gameDetailScrollController = ScrollController();
  final reviewScrollController = ScrollController();

  /// 게임 정보
  Rx<GameDetailResponseModel> gameDetail = GameDetailResponseModel(
    boardId: 0,
    writer: Writer(
      userId: 0,
      nickName: '',
    ),
    title: '',
    introduce: '',
    likeCount: 0,
    dislikeCount: 0,
    viewCount: 0,
    boardReviewCount: 0,
    boardReviewsPreview: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ).obs;

  /// 관련 게임 정보
  RxList<RelatedGameModel> relatedGameList = <RelatedGameModel>[].obs;

  @override
  void onInit() async {
    super.onInit();

    /// 게임 상세 조회
    await getGameDetail();

    /// 리뷰 스크롤 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double initialScrollPosition = reviewScrollController.position.maxScrollExtent / 2;
      reviewScrollController.jumpTo(initialScrollPosition);
    });

  }

  /// 게임 상세 조회
  Future<void> getGameDetail() async {
    final Map<String, dynamic> arguments = Get.arguments;
    final String parameterBoardId = arguments['boardId'] ?? '';

    if (parameterBoardId == '') {
      CustomSnackBar.showErrorSnackBar(
          title: '게임 조회 실패', message: '게임 정보를 불러올 수 없습니다.');
      Get.back();
      return;
    }

    gameDetail.value = await GameRepository().getGameDetail(parameterBoardId);
    relatedGameList.value = await GameRepository().getRelatedGame(parameterBoardId);
  }

  /// 게임 조회 변경
  Future<void> changeGameDetail(String boardId) async {
    // 게임 조회 변경
    gameDetail.value = await GameRepository().getGameDetail(boardId);
    relatedGameList.value = await GameRepository().getRelatedGame(boardId);
  }

  /// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 리뷰 신고 파트 변수 및 메서드 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

  /// 신고 내용
  final content = ''.obs;

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
    content.value = value;
    print('게임 신고 내용: ${content.value}');
  }

  /// 게임 신고 메서드
  Future<bool> gameReport(String reportContent) async {
    content.value = reportContent.isEmpty
        ? selectedCategory.value!.displayName
        : reportContent;

    try {
      final response = await GameRepository().reportGame(
          AuthController.to.accessToken.value,
          gameDetail.value.boardId,
          content.value);
      if (response) {
        print('(controller)게임 신고 성공');
        return true;
      } else {
        print('(controller)게임 신고 api조회 false');
        return false;
      }
    } on HttpException catch (e) {
      print('(controller)게임 신고 실패 - Http 예외: $e');
      rethrow;
    } catch (e) {
      print('(controller)게임 신고 api 받아오기 실패: $e');
      rethrow;
    }
  }

/// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

}
