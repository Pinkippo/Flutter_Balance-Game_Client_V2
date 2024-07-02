import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 로그인 컨트롤러 - main.dart에서 영속성 생성하여 사용
class LoginController extends GetxController {

  /// 로그인 폼 키
  final formKey = GlobalKey<FormState>();

  /// 아이디 컨트롤러
  final idController = TextEditingController();

  /// 비밀번호 컨트롤러
  final pwController = TextEditingController();

  /// 아이디
  final Rx<String> userId = Rx<String>('');

  /// 비밀번호
  final Rx<String> userPw = Rx<String>('');

  /// 자동 로그인 여부
  final RxBool autoLogin = false.obs;

  /// 아이디 변경
  void updateUserId(String id) {
    userId.value = id;
    print('ID >> $id');
  }

  /// 비밀번호 변경
  void updateUserPw(String pw) {
    userPw.value = pw;
    print('PW >> $pw');
  }

  /// 자동 로그인 토글
  void toggleAutoLogin() {
    autoLogin.value = !autoLogin.value;
    print('Auto Login >> ${autoLogin.value}');
  }

// void login() {
//   if (formKey.currentState!.validate()) {
//     print('로그인 성공');
//   }
// }

}
