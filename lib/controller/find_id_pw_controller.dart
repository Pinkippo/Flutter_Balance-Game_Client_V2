import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';

class FindIdPwController extends GetxController {
  /// 가입된 이메일
  final inputEmail = ''.obs;

  /// 찾을 계정의 ID
  final inputId = ''.obs;

  /// 로딩
  final isLoading = false.obs;

  void changeInputEmail(String email) {
    inputEmail.value = email;
    print('입력된 이메일 >>> $inputEmail');
  }

  void changeInputId(String id) {
    inputId.value = id;
    print('입력된 아이디 >>> $inputId');
  }

  /// 아이디 찾기
  Future<void> findId() async {
    try {
      isLoading.value = true;
      print('아이디 찾기 로딩 ======> $isLoading');
      final response = await AuthRepository()
          .findId(AuthController.to.accessToken.value, inputEmail.value);

      if (response) {
        Get.back();
        Get.snackbar(
          '성공',
          '아이디를 이메일로 발송했습니다.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // 실패 처리
        if (!Get.isSnackbarOpen) {
          // 스낵바가 열려 있지 않을 경우
          Get.snackbar(
            '실패',
            '이메일을 다시 확인해주세요.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      print('아이디 찾기 Error >> $e');
      if (!Get.isSnackbarOpen) {
        // 스낵바가 열려 있지 않을 경우
        Get.snackbar(
          '오류 발생',
          '아이디 찾기 중 오류가 발생했습니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
      print('아이디 찾기 로딩 ======> $isLoading');
    }
  }
}
