import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GameDetailController extends GetxController {
  /// 스크롤 컨트롤러
  final gameDetailScrollController = ScrollController();

  final reviewScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    /// 리뷰 스크롤 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double initialScrollPosition = reviewScrollController.position.maxScrollExtent / 2;
      reviewScrollController.jumpTo(initialScrollPosition);
    });

  }
}
