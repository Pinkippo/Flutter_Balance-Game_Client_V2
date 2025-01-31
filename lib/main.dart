import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/auth_controller.dart';
import 'package:yangjataekil/pref/app_preferences.dart';
import 'package:yangjataekil/route/app_pages.dart';
import 'package:yangjataekil/theme/app_thene.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/repository/auth_repository.dart';

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

  runApp(GestureDetector(
    onTap: () {
      Get.focusScope?.unfocus();
    },
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,

      /// 메인 페이지 라우트
      initialRoute: Routes.main,

      locale: const Locale('ko', 'KR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ko', 'KR'),
      ],
    ),
  ));
}

/// 앱 내에서 사용할 로그인 컨트롤러 등록
Future<void> initService() async {
  print("앱 초기화");
  /// 로그인 컨트롤러 영속성 설정
  await Get.putAsync<AuthController>(() async {
    final controller = AuthController();
    await controller.getToken();
    await controller.getUserInfoFromHomeScreen();
    await controller.getRejectReason();
    await controller.getVersion();
    return controller;
  }, permanent: true);
}
