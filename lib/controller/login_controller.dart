import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 로그인 컨트롤러

class LoginController extends GetxController {
  /// 로그인 폼 키
  final formKey = GlobalKey<FormState>();

  /// 아이디 컨트롤러
  final idController = TextEditingController();

  /// 비밀번호 컨트롤러
  final pwController = TextEditingController();

  final RxString userId = RxString('');

  final RxString userPw = RxString('');

  void updateUserId(String id) {
    userId.value = id;
    print('id: $id');
  }

  void updateUserPw(String pw) {
    userPw.value = pw;
  }

  /// 자동 로그인 여부
  final RxBool autoLogin = false.obs;

  /// 자동 로그인 토글
  void toggleAutoLogin() {
    autoLogin.value = !autoLogin.value;
  }

// void login() {
//   if (formKey.currentState!.validate()) {
//     print('로그인 성공');
//   }
// }
}
