import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';

import '../theme/app_color.dart';

/// 바텀 네비게이터 위젯
class CustomBottomNavigationBar extends GetView<BottomNavigatorController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: AppColors.primaryColor,
        onTap: controller.changeIndex,
        backgroundColor: Colors.white,
      ),
    );
  }
}
