import 'package:yangjataekil/route/auth_pages.dart';
import 'package:yangjataekil/route/game_pages.dart';
import 'package:yangjataekil/route/main_pages.dart';
import 'package:yangjataekil/route/review_pages.dart';
import 'package:yangjataekil/route/user_pages.dart';
part 'app_routes.dart';

/// 앱 내 페이지 경로 설정 클래스
class AppPages {
  static final pages = [
    ...MainPages.pages,
    ...AuthPages.pages,
    ...UserPages.pages,
    ...GamePages.pages,
    ...ReviewPages.pages,
  ];
}
