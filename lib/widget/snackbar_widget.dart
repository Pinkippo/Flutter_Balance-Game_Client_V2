import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/theme/app_color.dart';

class CustomSnackBar {
  /// 에러 스낵바
  static void showErrorSnackBar(
      {String title = '오류', required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  /// 성공 스낵바
  static void showSuccessSnackBar(
      {String title = '성공', required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  /// 일반 스낵바
  static void showSnackBar({String title = '알림', required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white.withOpacity(0.8),
    );
  }
}
