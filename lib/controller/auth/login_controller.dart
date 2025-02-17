import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/auth_controller.dart';
import 'package:yangjataekil/data/model/auth/login_request_model.dart';
import 'package:yangjataekil/data/repository/login_repository.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

import '../../data/model/auth/login_response_model.dart';
import '../../theme/app_color.dart';

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
  Future<LoginState> login(String id, String pw) async {
    if (loginUserId.value == '' || loginUserPw.value == '') {
      CustomSnackBar.showErrorSnackBar(title: '로그인 실패', message: '아이디와 비밀번호를 확인해주세요.');
      return LoginState.fail;
    }

    try {
      /// 로그인 API
      final LoginResponseModel response = await LoginRepository().login(
          LoginRequestModel(
              accountName: loginUserId.value, password: loginUserPw.value));

      if (response.accessToken.isNotEmpty) {
        /// 토큰 업데이트
        await AuthController.to
            .updateToken(response.accessToken, response.refreshToken);
        if (response.status == "BLOCK") {
          return LoginState.reject;
        } else {
          return LoginState.success;
        }
      } else {
        return LoginState.fail;
      }
    } catch(e) {
      /// 레포지토리에서 던진 에러 처리
      if (e.toString() == 'Exception: NOT_SIGN_UP_USER_ERROR') {
        CustomSnackBar.showErrorSnackBar(
            title: '로그인 실패',
            message: '가입되지 않은 사용자입니다.'
        );
      } else if (e.toString() == 'Exception: PASSWORD_MISMATCH_ERROR') {
        CustomSnackBar.showErrorSnackBar(
            title: '로그인 실패',
            message: '비밀번호가 일치하지 않습니다.'
        );
      } else {
        CustomSnackBar.showErrorSnackBar(
            title: '로그인 실패',
            message: '로그인 중 오류가 발생했습니다.'
        );
      }
      return LoginState.fail;
    }
  }
}

/// 로그인 완료 상태
enum LoginState { success, fail, reject}