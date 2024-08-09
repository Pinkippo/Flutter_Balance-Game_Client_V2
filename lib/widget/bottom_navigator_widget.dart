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
        // backgroundColor: Colors.white,
        // type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '게임목록',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '글작성',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),

        onTap: controller.changeIndex,
      ),
    );
  }
}
