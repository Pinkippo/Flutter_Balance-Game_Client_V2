import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/auth_controller.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';
import 'package:yangjataekil/controller/game/recommend_controller.dart';
import 'package:yangjataekil/controller/game/theme_controller.dart';
import 'package:yangjataekil/controller/list/all_list_controller.dart';
import 'package:yangjataekil/controller/notice/notice_controller.dart';
import 'package:yangjataekil/controller/notification_controller.dart';
import 'package:yangjataekil/route/app_pages.dart';
import 'package:yangjataekil/screen/mypage/notice_detail_screen.dart';
import 'package:yangjataekil/screen/mypage/notice_screen.dart';
import 'package:yangjataekil/screen/mypage/notification_screen.dart';
import 'package:yangjataekil/screen/tab/main_screen.dart';

class MainPages {
  static final pages = [
    /// 메인 페이지
    GetPage(
        name: Routes.main,
        page: () => const MainScreen(),
        transition: Transition.fade,
        binding: BindingsBuilder(() async {
          Get.lazyPut<BottomNavigatorController>(() {
            return BottomNavigatorController();
          });
          Get.put(AllListController());
          Get.lazyPut<ThemeController>(() {
            return ThemeController();
          });
          Get.lazyPut<RecommendController>(() {
            return RecommendController();
          });
          await Get.putAsync<AuthController>(() async {
            return AuthController();
          }, permanent: true)
              .then((value) async {
            await value.getToken();
            await value.getUserInfoFromHomeScreen();
            await value.checkRejectUser();
          });
        })),

    /// 알림 페이지
    GetPage(
      name: Routes.notification,
      page: () => const NotificationScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<NotificationController>(() {
          return NotificationController();
        });
      }),
    ),

    /// 공지사항 페이지
    GetPage(
        name: Routes.notice,
        page: () => const NoticeScreen(),
        transition: Transition.fade,
        binding: BindingsBuilder(() {
          Get.lazyPut<NoticeController>(() {
            return NoticeController();
          });
        })),

    /// 공지사항 상세 페이지
    GetPage(
      name: Routes.noticeDetail,
      page: () => const NoticeDetailScreen(),
      transition: Transition.fade,
    ),
  ];
}
