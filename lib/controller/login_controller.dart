import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';

/// 로그인 컨트롤러 - main.dart에서 영속성 생성하여 사용
class LoginController extends GetxController {
  /// 로그인 폼 키
  final formKey = GlobalKey<FormState>();

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

  /// 로그인 - 메서드
  Future<bool> login() async {
    if (userId.value == '' || userPw.value == '') {
      Get.snackbar('로그인 실패', '아이디와 비밀번호를 확인해주세요.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    // final LoginResponseModel response = await authRepository.login(LoginRequestModel(userId: loginUserId.value, userPw: loginUserPw.value));
    // if(response.token != ''){
    //   /// 토큰 저장 - 로그인 성공
    //   jwtToken.value = response.token;
    //   await storage.write(key: 'jwtToken', value: response.token);
    //
    //   // 유저 정보 호출
    //   final UserResponseModel userInfo = await authRepository.getUserInfo(response.token);
    //
    //   // 유저 정보 저장
    //   uid.value = userInfo.userId;
    //   userName.value = userInfo.userName;
    //   userEmail.value = userInfo.userEmail;
    //
    //   return true;
    // }else{
    //   /// 로그인 실패
    //   return false;
    // }
    print('로그인 성공!');
    return true;
  }
}
