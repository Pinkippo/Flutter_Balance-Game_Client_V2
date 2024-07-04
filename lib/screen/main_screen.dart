import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';
import 'package:yangjataekil/screen/tab/main_board_tap.dart';
import 'package:yangjataekil/screen/tab/main_home_tap.dart';
import 'package:yangjataekil/screen/tab/main_mypage_tap.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/bottom_navigator_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const List<Widget> tabPages = <Widget>[
    BoardTap(),
    HomeTap(),
    MyPageTap(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigatorController());

    return Scaffold(
      /// 앱바
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.secondaryColor,
        ),
      ),

      /// 바디
      body: Obx(() => SafeArea(
          child: tabPages[BottomNavigatorController.to.selectedIndex.value])),

      /// 바텀 네비게이션 바
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
