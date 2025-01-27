import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/agreeterms_controller.dart';
import 'package:yangjataekil/controller/auth/find_id_pw_controller.dart';
import 'package:yangjataekil/controller/auth/login_controller.dart';
import 'package:yangjataekil/controller/auth/register_controller.dart';
import 'package:yangjataekil/controller/auth/user_modify_controller.dart';
import 'package:yangjataekil/controller/game/game_play_controller.dart';
import 'package:yangjataekil/controller/game/game_upload_controller.dart';
import 'package:yangjataekil/controller/list/all_list_controller.dart';
import 'package:yangjataekil/controller/auth/auth_controller.dart';
import 'package:yangjataekil/controller/bottom_navigator_controller.dart';
import 'package:yangjataekil/controller/game/game_detail_controller.dart';
import 'package:yangjataekil/controller/game/game_review_controller.dart';
import 'package:yangjataekil/controller/game/theme_controller.dart';
import 'package:yangjataekil/controller/list/theme_list_controller.dart';
import 'package:yangjataekil/controller/notification_controller.dart';
import 'package:yangjataekil/controller/game/recommend_controller.dart';
import 'package:yangjataekil/controller/notice/notice_controller.dart';
import 'package:yangjataekil/screen/auth/change_pw_screen.dart';
import 'package:yangjataekil/screen/auth/delete_user_screen.dart';
import 'package:yangjataekil/screen/auth/find_id_or_pw_screen.dart';
import 'package:yangjataekil/screen/auth/reject_user_screen.dart';
import 'package:yangjataekil/screen/auth/user_modify_screen.dart';
import 'package:yangjataekil/screen/register/agreeterms_screen.dart';
import 'package:yangjataekil/screen/game/empty_game_detail_screen.dart';
import 'package:yangjataekil/screen/game/game_detail_screen.dart';
import 'package:yangjataekil/screen/game/game_play_screen.dart';
import 'package:yangjataekil/screen/game/game_result_screen.dart';
import 'package:yangjataekil/screen/game/list_screen.dart';
import 'package:yangjataekil/screen/auth/login_screen.dart';
import 'package:yangjataekil/screen/tab/main_screen.dart';
import 'package:yangjataekil/screen/mypage/my_records_screen.dart';
import 'package:yangjataekil/screen/mypage/my_reviews_screen.dart';
import 'package:yangjataekil/screen/mypage/participated_games_screen.dart';
import 'package:yangjataekil/screen/register/register_profile_screen.dart';
import 'package:yangjataekil/screen/mypage/notification_screen.dart';
import 'package:yangjataekil/screen/mypage/notice_screen.dart';
import 'package:yangjataekil/screen/register/register_screen.dart';
import '../controller/review/review_controller.dart';
import '../screen/game/game_review_screen.dart';
import '../screen/mypage/my_games_screen.dart';
import '../screen/mypage/notice_detail_screen.dart';
import '../screen/mypage/user_agreement_screen.dart';
import '../screen/review/review_list_screen.dart';
import '../screen/game/game_upload_screen.dart';

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

    /// 게임 업로드 페이지
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

    /// 테마별 리스트 페이지
    GetPage(
      name: Routes.list,
      page: () => const ListScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<ThemeListController>(() {
          return ThemeListController();
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

    /// 공지사항 상세 페이지
    GetPage(
      name: Routes.noticeDetail,
      page: () => const NoticeDetailScreen(),
      transition: Transition.fade,
    ),

    /// 게임 상세 페이지
    GetPage(
      name: Routes.gameDetail,
      page: () => const GameDetailScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<GameDetailController>(() => GameDetailController());
        Get.lazyPut<GamePlayController>(() => GamePlayController());
      }),
    ),

    /// 빈 게임 상세 페이지
    GetPage(
      name: Routes.emptyGameDetail,
      page: () => const EmptyGameDetailScreen(),
      transition: Transition.fade,
    ),

    /// 게임 플레이 페이지
    GetPage(
      name: Routes.gamePlay,
      page: () => const GamePlayScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<GamePlayController>(() => GamePlayController());
      }),
    ),

    /// 내가 쓴 게임 리스트 페이지
    GetPage(
        name: Routes.myGames,
        page: () => const MyGamesScreen(),
        transition: Transition.rightToLeftWithFade,
        binding: BindingsBuilder(() {
          Get.lazyPut<ThemeListController>(() {
            return ThemeListController();
          });
        })),

    /// 리뷰 리스트 페이지
    GetPage(
      name: Routes.reviewList,
      page: () => const ReviewListScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<ReviewController>(() {
          return ReviewController();
        });
      }),
    ),

    /// 게임 결과 페이지
    GetPage(
      name: Routes.gameResult,
      page: () => const GameResultScreen(),
      transition: Transition.fade,
    ),

    /// 게임 리뷰 등록 페이지
    GetPage(
        name: Routes.gameReview,
        page: () => const GameReviewScreen(),
        transition: Transition.fade,
        binding: BindingsBuilder(() {
          Get.lazyPut<GameReviewController>(() {
            return GameReviewController();
          });
        })),

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

    /// 내 활동 페이지
    GetPage(
      name: Routes.myRecords,
      page: () => const MyRecordsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    /// 내가 작성한 리뷰 페이지
    GetPage(
      name: Routes.myReviews,
      page: () => const MyReviewsScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: BindingsBuilder(() {
        Get.lazyPut<ReviewController>(() {
          return ReviewController();
        });
      }),
    ),

    /// 참여한 게임 리스트 페이지
    GetPage(
      name: Routes.participatedGames,
      page: () => const ParticipatedGamesScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: BindingsBuilder(() {
        Get.lazyPut<ThemeListController>(() {
          return ThemeListController();
        });
      }),
    ),

    /// ID or PW 찾기 페이지
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

    /// 비밀번호 찾기 페이지
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

    /// 이용약관 페이지
    GetPage(
      name: Routes.userAgreement,
      page: () => const UserAgreenment(),
      transition: Transition.fade,
    ),

  ];
}
