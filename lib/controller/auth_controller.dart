import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:yangjataekil/data/model/version_model.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';

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
  final Rx<String> accountName = Rx<String>('');
  final Rx<String> invitationCode = Rx<String>('');
  final Rx<String> profileUrl = Rx<String>('');
  final RxInt userBoardCount = RxInt(0);
  final Rx<String> version = Rx<String>('');
  final Rx<bool> isCurrent = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    getVersion();
  }
  /// 비밀번호 찾기
  final Rx<String> currentPw = Rx<String>('');
  final Rx<String> newPw = Rx<String>('');
  final Rx<String> newPwCheck = Rx<String>('');

  /// 비밀번호 입력
  void setCurrentPw(String value) {
    currentPw.value = value;
    print('현재 비밀번호 >>> $currentPw');
  }

  /// 새 비밀번호 입력
  void setNewPw(String value) {
    newPw.value = value;
    print('새 비밀번호 >>> $newPw');
  }

  /// 새 비밀번호 확인 입력
  void setNewPwCheck(String value) {
    newPwCheck.value = value;
    print('새 비밀번호 확인 >>> $newPwCheck');
  }

  /// 비밀번호 변경
  Future<void> changePw() async {
    // 비밀번호 확인
    if (newPw.value != newPwCheck.value || newPw.value.isEmpty) {
      Get.snackbar(
        '비밀번호 불일치',
        '새 비밀번호가 일치하지 않습니다.',
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // 비밀번호 변경 시도
      final String response = await authRepository.changePw(
          currentPw.value, newPw.value, accessToken.value);

      // 성공 시 처리
      if (response == 'SUCCESS') {
        Get.snackbar(
          '비밀번호 변경 성공',
          '비밀번호가 성공적으로 변경되었습니다.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAllNamed('/main');
      }
      // 현재 비밀번호 불일치 처리
      else if (response == 'PASSWORD_MISMATCH_ERROR') {
        Get.snackbar(
          '비밀번호 불일치',
          '현재 비밀번호가 일치하지 않습니다.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      // 기타 실패 처리
      else {
        Get.snackbar(
          '비밀번호 변경 실패',
          '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // 오류 출력 및 사용자 알림
      print('비밀번호 변경 Error >> $e');
      Get.snackbar(
        '오류 발생',
        '비밀번호 변경 중 오류가 발생했습니다.',
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// 유저 데이터 조회
  Future<void> fetchUserData() async {
    final UserResponseModel response =
        await authRepository.getUserInfo(accessToken.value);
    try {
      uid.value = response.userId;
      nickname.value = response.nickname;
      email.value = response.email;
      pushToken.value = response.pushToken;
      realName.value = response.realName;
      birth.value = response.birth;
      accountName.value = response.accountName;
      invitationCode.value = response.invitationCode;
      profileUrl.value = response.profileUrl;

      print('유저 정보 조회, profileUrl>> ${profileUrl.value}');
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
      await fetchUserData();
    }
  }

  /// 로그아웃
  Future<void> logout() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    accessToken.value = '';
    refreshToken.value = '';
  }

  /// 홈 화면 유저 정보 조회
  Future<void> getUserInfoFromHomeScreen() async {
    // 토큰이 유효한지 확인
    if (accessToken.value.isEmpty) {
      print('홈 화면 유저 정보 조회 실패>>>>>>>>>>>>>>>>>>> 토큰 없음');
      return;
    }

    try {
      final UserInfoFromHomeScreenModel response =
          await authRepository.getUserInfoFromHomeScreen(accessToken.value);

      userBoardCount.value = response.myBoardCount;
    } catch (e) {
      print('Error while fetching user info: $e');
      Get.snackbar(
        '오류 발생',
        '유저 정보를 조회하는 중 오류가 발생했습니다.',
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// 회원탈퇴
  Future<void> deleteUser() async {
    try {
      await authRepository.deleteUser(accessToken.value);
      await logout();
      Get.offAllNamed('/main');
    } catch (e) {
      print('Error while deleting user: $e');
      Get.snackbar(
        '오류 발생',
        '회원 탈퇴 중 오류가 발생했습니다.',
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// 버전조회
  Future<void> getVersion() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String appVersion = packageInfo.version;

      final VersionModel response = await authRepository.getVersion();
      print('버전 정보 조회, profileUrl>> ${response.toString()}');

      final checkVersion = _checkVersion(appVersion, response.minimumVersion);
      if (checkVersion == -1) {
          // TODO: 업데이트 유도 링크 추가
          print('업데이트 해야합니다');
      } else if (checkVersion == 0) {
        isCurrent.value = true;
      }
      version.value = appVersion;
    } catch (e) {
      print('버전 조회 실패: $e');
      Get.snackbar(
        '오류 발생',
        '버전 정보를 조회하는 중 오류가 발생했습니다.',
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

int _checkVersion(String appVersion, String minimumVersion) {
  List<int> appVersionList = appVersion.split('.').map(int.parse).toList();
  List<int> minimumVersionList = minimumVersion.split('.').map(int.parse).toList();

  for (int i=0; i< appVersionList.length; i++) {
    if (appVersionList[i] > minimumVersionList[i]) return 1;
    if (appVersionList[i] < minimumVersionList[i]) return -1;
  }
  return 0;
}