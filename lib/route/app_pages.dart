import 'package:get/get.dart';
import 'package:yangjataekil/app.dart';

part 'app_routes.dart';

/// 앱 내 페이지 경로 설정 클래스  
class AppPages {
  static final pages = [

    /// 초기 페이지
    GetPage(
      name: Routes.initial, page: () => const App(), transition: Transition.fade
    ),

  ];
}