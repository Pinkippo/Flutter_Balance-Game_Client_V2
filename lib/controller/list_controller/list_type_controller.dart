import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum GameListType {
  all,        // 전체 게임 리스트
  theme,      // 테마별 게임 리스트
  myGames,    // 내 게임 리스트
}

class ListTypeController extends GetxController {
  static ListTypeController get to => Get.find();

  final Rx<GameListType> gameListType = GameListType.all.obs;

  void changeGameListType(GameListType type) {
    gameListType.value = type;
  }
}