import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/webview_controller/WebviewController.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // myWebViewController 인스턴스 생성
    final MyWebViewController controller = Get.put(MyWebViewController());

    // 매개변수로 받은 url을 controller에 설정
    controller.setUrl(url);
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
          // controller 초기화 여부에 따라 화면 표시
          if (!controller.isInitialized.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (controller.isLoading.value) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          } else {
            return Container(
                color: Colors.white,
                child: WebViewWidget(controller: controller.getController()));
          }
        },
      ),
    );
  }
}
