import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/model/login_request_model.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';
import 'package:yangjataekil/data/provider/login_repository.dart';

import '../data/model/login_response_model.dart';
import '../data/model/user_response_model.dart';
import '../theme/app_color.dart';

/// 로그인 컨트롤러 - main.dart에서 영속성 생성하여 사용
class AuthController extends GetxController {

  static AuthController get to => Get.find();

  /// 생성자
  AuthController() {
    authRepository = AuthRepository();
  }

  late final AuthRepository authRepository;
  final storage = const FlutterSecureStorage();

  /// 엑세시 토큰
  final Rx<String> accessToken = Rx<String>('');

  /// 리프레시 토큰
  final Rx<String> refreshToken = Rx<String>('');

  /// 유저 정보
  final RxInt uid = RxInt(0);
  final Rx<String> nickname = Rx<String>('');
  final Rx<String> email = Rx<String>('');
  final Rx<String> pushToken = Rx<String>('');
  final Rx<String> realName = Rx<String>('');
  final Rx<String> birth = Rx<String>('');
  final Rx<String> phoneNumber = Rx<String>('');
  final Rx<String> invitationCode = Rx<String>('');

  /// 유저 데이터 조회
  Future<void> fetchUserData() async {
    final UserResponseModel response = await authRepository.getUserInfo(accessToken.value);
    try {
      uid.value = response.userId;
      nickname.value = response.nickname;
      email.value = response.email;
      pushToken.value = response.pushToken;
      realName.value = response.realName;
      birth.value = response.birth;
      phoneNumber.value = response.phoneNumber;
      invitationCode.value = response.invitationCode;
    } catch (e) {
      print('Error >> $e');
    }
  }

  /// 토큰 정보 수정
  Future<void> updateToken(String access, String refresh) async {
    await storage.write(key: 'accessToken', value: access);
    await storage.write(key: 'refreshToken', value: refresh);
    accessToken.value = access;
    refreshToken.value = refresh;
  }

  /// 로컬 토큰 정보 조회 후 업데이트
  Future<void> getToken() async {
    final String? access = await storage.read(key: 'accessToken');
    final String? refresh = await storage.read(key: 'refreshToken');
    if (access != null && refresh != null) {
      accessToken.value = access;
      refreshToken.value = refresh;
    }
  }

  /// 로그아웃
  Future<void> logout() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    accessToken.value = '';
    refreshToken.value = '';
  }

}
