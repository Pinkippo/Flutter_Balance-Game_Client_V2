import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/login_request_model.dart';
import 'package:yangjataekil/data/provider/login_repository.dart';

import '../data/model/login_response_model.dart';
import '../theme/app_color.dart';

/// 로그인 컨트롤러 - main.dart에서 영속성 생성하여 사용
class LoginController extends GetxController {

  /// 로그인 폼 키
  final formKey = GlobalKey<FormState>();

  /// 로그인 아이디
  final Rx<String> loginUserId = Rx<String>('');

  /// 로그인 비밀번호
  final Rx<String> loginUserPw = Rx<String>('');

  /// 자동 로그인 여부
  final RxBool autoLogin = false.obs;

  /// 아이디 변경
  void updateUserId(String id) {
    loginUserId.value = id;
    print('ID >> $id');
  }

  /// 비밀번호 변경
  void updateUserPw(String pw) {
    loginUserPw.value = pw;
    print('PW >> $pw');
  }

  /// 자동 로그인 토글
  void toggleAutoLogin() {
    autoLogin.value = !autoLogin.value;
    print('Auto Login >> ${autoLogin.value}');
  }

  /// 로그인 - 메서드
  Future<bool> login(String id, String pw) async {
    if (loginUserId.value == '' || loginUserPw.value == '') {
      Get.snackbar('로그인 실패', '아이디와 비밀번호를 확인해주세요.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    /// 로그인 API
    final LoginResponseModel response = await LoginRepository().login(
        LoginRequestModel(
            accountName: loginUserId.value, password: loginUserPw.value));

    if (response.accessToken.isNotEmpty) {
      /// 토큰 업데이트
      await AuthController()
          .updateToken(response.accessToken, response.refreshToken);
      return true;
    } else {
      return false;
    }
  }
}
