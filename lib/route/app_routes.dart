part of 'app_pages.dart';

/// 앱 페이지 경로 설정 클래스
abstract class Routes{

  Routes._(); // 생성자 private

  /// 페이지 경로
  static const initial = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const main = '/main';
  static const findId = '/find_id';
  static const findPw = '/find_pw';
  static const board = '/board';
  static const home = '/home';
  static const myPage = '/my_page';

}