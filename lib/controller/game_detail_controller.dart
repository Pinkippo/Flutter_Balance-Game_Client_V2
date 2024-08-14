import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/model/game/game_detail_response_model.dart';
import 'package:yangjataekil/data/model/game/game_detail_writer.dart';
import 'package:yangjataekil/data/model/game/related_game_model.dart';
import 'package:yangjataekil/data/provider/game_repository.dart';
import 'package:yangjataekil/theme/app_color.dart';

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
      Get.snackbar(
        '게임 조회 오류',
        '잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
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

}
