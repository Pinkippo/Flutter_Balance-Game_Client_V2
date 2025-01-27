import 'package:get/get.dart';
import 'package:yangjataekil/controller/game/game_review_controller.dart';
import 'package:yangjataekil/controller/review/review_controller.dart';
import 'package:yangjataekil/route/app_pages.dart';
import 'package:yangjataekil/screen/review/review_list_screen.dart';
import 'package:yangjataekil/screen/review/review_upload_screen.dart';

class ReviewPages {
  static final pages = [
    /// 리뷰 등록 페이지
    GetPage(
      name: Routes.gameReview,
      page: () => const ReviewUploadScreen(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.lazyPut<GameReviewController>(() {
          return GameReviewController();
        });
      }),
    ),

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
  ];
}
