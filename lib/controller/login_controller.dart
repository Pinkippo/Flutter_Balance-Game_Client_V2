import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/model/login_request_model.dart';
import 'package:yangjataekil/data/provider/api.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';
import 'package:yangjataekil/data/provider/login_repository.dart';

import '../data/model/login_response_model.dart';
import '../data/model/user_response_model.dart';
import '../theme/app_color.dart';

/// 로그인 컨트롤러 - main.dart에서 영속성 생성하여 사용
class LoginController extends GetxController {
  LoginController({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  /// 보안 저장소 - Jwt Token 보관
  final storage = const FlutterSecureStorage();

  /// 로그인 폼 키
  final formKey = GlobalKey<FormState>();

  /// 로그인 아이디
  final Rx<String> loginUserId = Rx<String>('');

  /// 로그인 비밀번호
  final Rx<String> loginUserPw = Rx<String>('');

  /// 토큰
  final Rx<String> jwtToken = Rx<String>('');

  /// 유저 정보
  final RxInt uid = RxInt(0); // 유저 uid
  final Rx<String> nickname = Rx<String>(''); // 유저 닉네임
  final Rx<String> email = Rx<String>(''); // 유저 이메일

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

    // 로그인 요청
    final LoginResponseModel response = await LoginRepository().login(
        LoginRequestModel(
            email: loginUserId.value, password: loginUserPw.value));

    if (response.accessToken.isNotEmpty) {
      /// 토큰 저장 - 로그인 성공
      jwtToken.value = response.accessToken;
      await storage.write(key: 'jwtToken', value: response.accessToken);
      print('jwtToken: ${jwtToken.value}');

      // 유저 정보 호출
      final UserResponseModel userInfo =
          await authRepository.getUserInfo(jwtToken.value);

      // 유저 정보 저장
      uid.value = userInfo.userId;
      nickname.value = userInfo.nickname;
      email.value = userInfo.email;

      print('uid.value: ${uid.value}');
      print('nickname.value: ${nickname.value}');
      print('email.value: ${email.value}');

      return true;
    } else {
      /// 로그인 실패
      return false;
    }
    print('로그인 성공!');
    return true;
  }
}
