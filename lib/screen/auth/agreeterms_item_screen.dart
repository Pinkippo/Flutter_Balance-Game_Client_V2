import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yangjataekil/controller/web_view/WebviewController.dart';

class AgreeTermsItemScreen extends StatelessWidget {
  final String url;

  const AgreeTermsItemScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // myWebViewController 인스턴스 생성
    final MyWebViewController controller = Get.put(MyWebViewController(url));

    // 매개변수로 받은 url을 controller에 설정
    // controller.setUrl(url);
    print('웹뷰 url>>>>>>>>: $url');

    return Scaffold(
      appBar: AppBar(
        title: const Text('약관동의',
            style: const TextStyle(fontSize: 18, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () {
          // 컨트롤러가 초기화되었는지 확인
          if (!controller.isInitialized.value) {
            return Container(
              color: Colors.white.withOpacity(0.5), // 반투명 배경
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          }

          return Stack(
            children: [
              // WebView 위젯
              Container(
                color: Colors.white,
                child: WebViewWidget(controller: controller.getController()),
              ),

              // 로딩 인디케이터
              if (controller.isLoading.value)
                Container(
                  color: Colors.white.withOpacity(0.5), // 반투명 배경
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
