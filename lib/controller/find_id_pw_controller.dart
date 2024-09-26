import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      final response = await AuthRepository().findId(inputEmail.value);

      if (response == 200) {
        Get.back();
        Get.snackbar(
          '성공',
          '아이디를 이메일로 발송했습니다.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response == 400) {
        Get.snackbar(
          '실패',
          '가입된 이메일이 없습니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // 스낵바가 열려 있지 않을 경우
        Get.snackbar(
          '실패',
          '아이디 찾기 중 오류가 발생했습니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('아이디 찾기 Error >> $e');
      Get.snackbar(
        '오류 발생',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      print('아이디 찾기 로딩 ======> $isLoading');
    }
  }

  /// 비밀번호 찾기
  Future<void> findPw() async {
    try {
      isLoading.value = true;
      print('비밀번호 찾기 로딩 ======> $isLoading');
      final response = await AuthRepository().findPw(inputId.value);

      if (response == 200) {
        Get.back();
        Get.snackbar(
          '성공',
          '가입된 이메일로 임시 비밀번호를 발송했습니다.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response == 400) {
        Get.snackbar(
          '실패',
          '존재하지 않는 아이디입니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // 스낵바가 열려 있지 않을 경우
        Get.snackbar(
          '실패',
          '비밀번호 찾기 중 오류가 발생했습니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('비밀번호 찾기 Error >> $e');
      if (!Get.isSnackbarOpen) {
        // 스낵바가 열려 있지 않을 경우
        Get.snackbar(
          '오류 발생',
          '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
      print('비밀번호 찾기 로딩 ======> $isLoading');
    }
  }
}
