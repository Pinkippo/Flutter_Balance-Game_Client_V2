import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/auth_controller.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';
import 'package:yangjataekil/route/app_pages.dart';
import 'package:yangjataekil/screen/tab/main_all_list_tap.dart';
import 'package:yangjataekil/screen/tab/main_home_tap.dart';
import 'package:yangjataekil/screen/tab/main_mypage_tap.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/bottom_navigator_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const List<Widget> tabPages = <Widget>[
    MainAllListTap(),
    HomeTap(),
    MyPageTap(),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    /// 스플래시 제거
    FlutterNativeSplash.remove();

    print('메인 스크린 INIT');
    print('ACCESS TOKEN : ${AuthController.to.accessToken.value}');
    print('REFRESH TOKEN : ${AuthController.to.accessToken.value}');

    /// 화면 빌드가 끝난 후 차단 유저인 경우 차단 페이지 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AuthController.to.isRejectUser.value) {
        Get.offAllNamed(Routes.rejectUser);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /// 앱바
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Obx(() {
          Color appBarColor;
          if (BottomNavigatorController.to.selectedIndex.value == 1) {
            appBarColor = AppColors.primaryColor; // 홈 탭의 색상
          } else {
            appBarColor = Colors.white; // 기본 색상
          }
          return Container(
            color: appBarColor,
          );
        }),
      ),

      /// 바디
      body: Obx(() => SafeArea(
          child: MainScreen.tabPages[BottomNavigatorController.to.selectedIndex.value])),

      /// 바텀 네비게이션 바
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
