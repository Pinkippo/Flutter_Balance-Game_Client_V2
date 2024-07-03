import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/login_controller.dart';
import 'package:yangjataekil/pref/app_preferences.dart';
import 'package:yangjataekil/route/app_pages.dart';
import 'package:yangjataekil/theme/app_thene.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// .env 파일 로드
  await dotenv.load(fileName: 'assets/config/.env');

  /// 세로모드 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// 스플래시 생성
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// 앱 설정 파일 로드
  await AppPreferences.init();

  /// 로그인 검증 및 로그인 컨트롤러 초기화
  await initService();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    initialRoute: Routes.initial,
  ));
}

/// 앱 내에서 사용할 로그인 컨트롤러 등록
Future<void> initService() async {

  /// 로그인 컨트롤러 영속성 설정
  await Get.putAsync<LoginController>(() async {
    return LoginController();
  }, permanent: true)
      .then((value) async {
    /// TODO : 로그인 검증 로직
  });

}
