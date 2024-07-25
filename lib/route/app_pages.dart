import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';
import 'package:yangjataekil/controller/game_upload_controller.dart';
import 'package:yangjataekil/controller/login_controller.dart';
import 'package:yangjataekil/controller/notification_controller.dart';
import 'package:yangjataekil/controller/register_controller.dart';
import 'package:yangjataekil/controller/tab/theme_list_controller.dart';
import 'package:yangjataekil/controller/notice_controller.dart';
import 'package:yangjataekil/screen/login_screen.dart';
import 'package:yangjataekil/screen/main_screen.dart';
import 'package:yangjataekil/screen/register_profile_screen.dart';
import 'package:yangjataekil/screen/notification_screen.dart';
import 'package:yangjataekil/screen/notice_screen.dart';
import 'package:yangjataekil/screen/register_screen.dart';

import '../controller/agreeterms_controller.dart';
import '../screen/agreeterms_screen.dart';
import '../screen/upload_game_screen.dart';

part 'app_routes.dart';

/// 앱 내 페이지 경로 설정 클래스
class AppPages {
  static final pages = [
    /// 로그인 페이지
    GetPage(
        name: Routes.login,
        page: () => const LoginScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LoginController>(() {
            return LoginController();
          });
        }),
        transition: Transition.fade),

    /// 메인 페이지
    GetPage(
        name: Routes.main,
        page: () => const MainScreen(),
        transition: Transition.fade,
        binding: BindingsBuilder(() async {
          Get.lazyPut<BottomNavigatorController>(() {
            return BottomNavigatorController();
          });
          Get.lazyPut<ThemeListController>(() {
            return ThemeListController();
          });
          await Get.putAsync<AuthController>(() async {
            return AuthController();
          }, permanent: true)
              .then((value) async {
            await value.getToken();
          });
        })),

    /// 회원가입 페이지
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() {
          return RegisterController();
        });
      }),
    ),

    /// 이용약관 페이지
    GetPage(
      name: Routes.agreeTerms,
      page: () => const AgreeTermsScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(
        () {
          Get.lazyPut<AgreeTermsController>(() {
            return AgreeTermsController();
          });
        },
      ),
    ),

    /// 프로필 등록 페이지
    GetPage(
      name: Routes.profile,
      page: () => const RegisterProfileScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() {
          return RegisterController();
        });
      }),
    ),

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

    GetPage(
      name: Routes.uploadGame,
      page: () => const UploadGameScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<GameUploadController>(() {
          return GameUploadController();
        });
      }),
    ),
  ];
}
