import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeModel {
  final String theme;
  final IconData icon;

  ThemeModel({
    required this.theme,
    required this.icon,
  });
}

class ThemeListController extends GetxController {
  static ThemeListController get to => Get.find();

  List<ThemeModel> themeList = [
    ThemeModel(theme: '직장인', icon: Icons.shopping_bag_outlined),
    ThemeModel(theme: '학생', icon: Icons.school_outlined),
    ThemeModel(theme: '동물', icon: Icons.pets_outlined),
    ThemeModel(theme: '음식', icon: Icons.fastfood_outlined),
    ThemeModel(theme: '몰라', icon: Icons.add_circle_outline),
  ];

  final RxString selectedTheme = ''.obs;

  void changeIndex(String theme) {
    selectedTheme(theme);
  }

  /// 화면 이동 메서드
  void navigateToThemeGames() {
    Get.toNamed('/list');
    print('테마별 게임 화면으로 이동 >> 테마: ${selectedTheme.value}');
  }
}
