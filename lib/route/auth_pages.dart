import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/agreeterms_controller.dart';
import 'package:yangjataekil/controller/auth/find_id_pw_controller.dart';
import 'package:yangjataekil/controller/auth/login_controller.dart';
import 'package:yangjataekil/controller/auth/register_controller.dart';
import 'package:yangjataekil/controller/auth/user_modify_controller.dart';
import 'package:yangjataekil/route/app_pages.dart';
import 'package:yangjataekil/screen/auth/change_pw_screen.dart';
import 'package:yangjataekil/screen/auth/delete_user_screen.dart';
import 'package:yangjataekil/screen/auth/find_id_or_pw_screen.dart';
import 'package:yangjataekil/screen/auth/login_screen.dart';
import 'package:yangjataekil/screen/auth/reject_user_screen.dart';
import 'package:yangjataekil/screen/auth/user_modify_screen.dart';
import 'package:yangjataekil/screen/register/agreeterms_screen.dart';
import 'package:yangjataekil/screen/register/register_profile_screen.dart';
import 'package:yangjataekil/screen/register/register_screen.dart';

class AuthPages {
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

    /// 비밀번호 변경 페이지
    GetPage(
      name: Routes.changePw,
      page: () => const ChangePwScreen(),
      transition: Transition.fade,
    ),

    /// 내 정보 수정 페이지
    GetPage(
      name: Routes.myPageModify,
      page: () => const UserModifyScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<UserModifyController>(() {
          return UserModifyController();
        });
      }),
    ),

    /// 회원 탈퇴 페이지
    GetPage(
      name: Routes.deleteUser,
      page: () => const DeleteUserScreen(),
      transition: Transition.fade,
    ),

    /// 차단회원 페이지
    GetPage(
      name: Routes.rejectUser,
      page: () => const RejectUserScreen(),
      transition: Transition.fade,
    ),

    /// ID 찾기 페이지
    GetPage(
      name: Routes.findId,
      page: () => const FindIdOrPw(findType: "id"),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<FindIdPwController>(() {
          return FindIdPwController();
        });
      }),
    ),

    /// PW 찾기 페이지
    GetPage(
      name: Routes.findPw,
      page: () => const FindIdOrPw(findType: "pw"),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<FindIdPwController>(() {
          return FindIdPwController();
        });
      }),
    ),
  ];
}
