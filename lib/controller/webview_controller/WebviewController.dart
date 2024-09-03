import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 웹뷰 컨트롤러
class MyWebViewController extends GetxController {
  /// GetX 컨트롤러 인스턴스 생성
  static MyWebViewController get to => Get.find();

  /// 웹뷰 컨트롤러
  late WebViewController controller;

  /// 로딩 상태
  final isLoading = false.obs;

  /// 초기화 상태
  final isInitialized = false.obs; // 초기화 상태를 관리하는 변수

  /// 웹뷰 URL
  final url = ''.obs;

  /// 생성자
  MyWebViewController(String url) {
    this.url.value = url;
  }

  @override
  void onInit() async {
    super.onInit();
    print('웹뷰컨트롤러 초기화 시작');
    await setUrl(url.value);
    await setupController(); // setupController 호출을 await
    isInitialized.value = true; // 초기화 완료 상태 설정
    print('웹뷰컨트롤러 초기화 완료');
  }

  /// 컨트롤러 설정
  Future<void> setupController() async {
    isLoading.value = true; // 로딩 시작
    controller = WebViewController(); // 컨트롤러 초기화

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('Loding: $progress%');
          },
          onPageStarted: (String url) {
            print('페이지 시작: $url');
          },
          onPageFinished: (String url) async {
            print('페이지 로드 완료: $url');
            isLoading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            print('웹 리소스 에러: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https:') ||
                request.url.startsWith('http:')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url.value));
  }

  /// 컨트롤러 반환
  WebViewController getController() {
    return controller;
  }

  /// URL 설정
  Future<void> setUrl(String url) async {
    this.url.value = url;
  }
}
