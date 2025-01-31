import 'package:get/get.dart';
import 'package:yangjataekil/controller/game/game_detail_controller.dart';
import 'package:yangjataekil/controller/game/game_play_controller.dart';
import 'package:yangjataekil/controller/game/game_upload_controller.dart';
import 'package:yangjataekil/controller/list/theme_list_controller.dart';
import 'package:yangjataekil/route/app_pages.dart';
import 'package:yangjataekil/screen/game/empty_game_detail_screen.dart';
import 'package:yangjataekil/screen/game/game_detail_screen.dart';
import 'package:yangjataekil/screen/game/game_play_screen.dart';
import 'package:yangjataekil/screen/game/game_result_screen.dart';
import 'package:yangjataekil/screen/game/game_upload_screen.dart';
import 'package:yangjataekil/screen/game/list_screen.dart';

class GamePages {
  static final pages = [
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

    /// 게임 플레이 페이지
    GetPage(
      name: Routes.gamePlay,
      page: () => const GamePlayScreen(),
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

    /// 게임 결과 페이지
    GetPage(
      name: Routes.gameResult,
      page: () => const GameResultScreen(),
      transition: Transition.fade,
    ),

    /// 빈 게임 상세 페이지
    GetPage(
      name: Routes.emptyGameDetail,
      page: () => const EmptyGameDetailScreen(),
      transition: Transition.fade,
    ),
  ];
}
