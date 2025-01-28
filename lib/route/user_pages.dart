import 'package:get/get.dart';
import 'package:yangjataekil/controller/list/theme_list_controller.dart';
import 'package:yangjataekil/controller/review/review_controller.dart';
import 'package:yangjataekil/route/app_pages.dart';
import 'package:yangjataekil/screen/mypage/my_games_screen.dart';
import 'package:yangjataekil/screen/mypage/my_records_screen.dart';
import 'package:yangjataekil/screen/mypage/my_reviews_screen.dart';
import 'package:yangjataekil/screen/mypage/participated_games_screen.dart';
import 'package:yangjataekil/screen/mypage/user_agreement_screen.dart';

class UserPages {
  static final pages = [
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

    /// 내가 참여한 게임 리스트 페이지
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

    /// 내가 만든 게임 리스트 페이지
    GetPage(
        name: Routes.myGames,
        page: () => const MyGamesScreen(),
        transition: Transition.rightToLeftWithFade,
        binding: BindingsBuilder(() {
          Get.lazyPut<ThemeListController>(() {
            return ThemeListController();
          });
        })),

    /// 마이페이지 내부 이용약관 페이지
    GetPage(
      name: Routes.userAgreement,
      page: () => const UserAgreenment(),
      transition: Transition.fade,
    ),
  ];
}
