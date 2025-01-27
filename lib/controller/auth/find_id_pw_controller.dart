import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/repository/auth_repository.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

class FindIdPwController extends GetxController {
  /// 가입된 이메일
  final Rx<String> inputEmail = Rx<String>('');

  /// 찾을 계정의 ID
  final Rx<String> inputId = Rx<String>('');

  /// 로딩
  final Rx<bool> isLoading = Rx<bool>(false);

  /// 이메일 입력
  void changeInputEmail(String email) {
    inputEmail.value = email;
    print('입력된 이메일 >>> $inputEmail');
  }

  /// 아이디 입력
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
        CustomSnackBar.showSuccessSnackBar(message: '가입된 이메일로 아이디를 발송했습니다.');
      } else if (response == 400) {
        CustomSnackBar.showErrorSnackBar(message: '가입된 이메일이 없습니다.');
      } else {
        // 스낵바가 열려 있지 않을 경우
        CustomSnackBar.showErrorSnackBar(message: '아이디 찾기 중 오류가 발생했습니다.');
      }
    } catch (e) {
      print('아이디 찾기 Error >> $e');
        CustomSnackBar.showErrorSnackBar(message: '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.');
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
        CustomSnackBar.showSuccessSnackBar(message: '가입된 이메일로 임시 비밀번호를 발송했습니다.');
      } else if (response == 400) {
        CustomSnackBar.showErrorSnackBar(message: '존재하지 않는 아이디입니다.');
      } else {
        CustomSnackBar.showErrorSnackBar(message: '비밀번호 찾기 중 오류가 발생했습니다.');
      }
    } catch (e) {
      print('비밀번호 찾기 Error >> $e');
      CustomSnackBar.showErrorSnackBar(message: '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.');
    } finally {
      isLoading.value = false;
      print('비밀번호 찾기 로딩 ======> $isLoading');
    }
  }
}
