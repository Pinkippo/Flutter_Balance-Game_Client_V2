import 'package:get/get.dart';
import 'package:yangjataekil/app.dart';
import 'package:yangjataekil/screen/login_screen.dart';
import 'package:yangjataekil/screen/tab/tabs.dart';

part 'app_routes.dart';

/// 앱 내 페이지 경로 설정 클래스
class AppPages {
  static final pages = [
    /// 초기 페이지
    GetPage(
        name: Routes.initial,
        page: () => const App(),
        transition: Transition.fade),
    GetPage(
        name: Routes.login,
        page: () => const LoginScreen(),
        transition: Transition.fade),
    GetPage(
        name: Routes.main,
        page: () => const Tabs(),
        transition: Transition.fade),
    // GetPage(
    //     name: Routes.board,
    //     page: () => const Board(),
    //     transition: Transition.fade),

    // GetPage(
    //     name: Routes.myPage,
    //     page: () => const MyPage(),
    //     transition: Transition.fade),
  ];
}
