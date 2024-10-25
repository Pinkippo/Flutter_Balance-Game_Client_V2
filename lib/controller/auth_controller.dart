import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:yangjataekil/data/model/reject_reason_response_model.dart';
import 'package:yangjataekil/data/model/version_model.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

import '../data/model/user_response_model.dart';
import '../theme/app_color.dart';

enum DELETEREASONS {
  // 개인정보가 걱정돼요
  personalInfo,
  // 자주 사용하지 않음
  notUsedOften,
  // 앱 용량이 커요
  appSize,
  // 알람이 너무 자주 와요
  tooManyAlarms,
  // 앱 오류가 있어요
  appError,
  // 직접입력
  directInput,
}

extension DeleteReasonExtension on DELETEREASONS {
  String get name {
    switch (this) {
      case DELETEREASONS.personalInfo:
        return '개인정보가 걱정돼요';
      case DELETEREASONS.notUsedOften:
        return '자주 사용하지 않아요';
      case DELETEREASONS.appSize:
        return '앱 용량이 커요';
      case DELETEREASONS.tooManyAlarms:
        return '알람이 너무 자주 와요';
      case DELETEREASONS.appError:
        return '앱 오류가 있어요';
      case DELETEREASONS.directInput:
        return '직접입력';
    }
  }
}

/// 로그인 컨트롤러 - main.dart에서 영속성 생성하여 사용
class AuthController extends GetxController {
  static AuthController get to => Get.find();

  /// 탈퇴 사유
  final deleteReasons = DELETEREASONS.values;

  /// 선택된 탈퇴 사유
  final selectedDeleteReason = DELETEREASONS.personalInfo.obs;

  /// 기타사유
  final directInputReason = ''.obs;

  /// 기타 사유일 경우 텍스트 입력
  final directInputText = ''.obs;

  /// 기타사유 입력
  void changeDirectInputText(String value) {
    directInputText.value = value;
    print('기타사유 입력 >>> $directInputText');
  }

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

  /// 차단 여부
  final RxBool isRejectUser = RxBool(false);

  /// 차단한 어드민
  final Rx<String> rejectAdminName = Rx<String>('익명의 어드민1');

  /// 차단 당한 이유
  final Rx<String> rejectReason =  Rx<String>('규정 위반으로 차단되었습니다.');

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

  /// 비밀번호 변경
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
      CustomSnackBar.showErrorSnackBar(
          title: '비밀번호 불일치',
          message: '새 비밀번호가 일치하지 않습니다');
      return;
    }

    try {
      // 비밀번호 변경 시도
      final String response = await authRepository.changePw(
          currentPw.value, newPw.value, accessToken.value);

      // 성공 시 처리
      if (response == 'SUCCESS') {
        CustomSnackBar.showSuccessSnackBar(
            title: '비밀번호 변경 성공', message: '비밀번호가 변경되었습니다.');
        Get.offAllNamed('/main');
      }
      // 현재 비밀번호 불일치 처리
      else if (response == 'PASSWORD_MISMATCH_ERROR') {
        CustomSnackBar.showErrorSnackBar(
            title: '비밀번호 변경 실패',
            message: '현재 비밀번호가 일치하지 않습니다.');
      }
      // 기타 실패 처리
      else {
        CustomSnackBar.showErrorSnackBar(
            title: '비밀번호 변경 실패', message: '다시 시도해주세요.');
      }
    } catch (e) {
      // 오류 출력 및 사용자 알림
      print('비밀번호 변경 Error >> $e');
      CustomSnackBar.showErrorSnackBar(
          title: '비밀번호 변경 실패', message: '다시 시도해주세요.');
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
    isRejectUser.value = false;
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
      CustomSnackBar.showErrorSnackBar(
          title: '유저 정보 조회 실패', message: '다시 시도해주세요.');
    }
  }

  /// 회원탈퇴
  Future<void> deleteUser() async {
    final String deleteReason = selectedDeleteReason.value == DELETEREASONS.directInput
        ? directInputText.value
        : selectedDeleteReason.value.name;

    try {
      await authRepository.deleteUser(accessToken.value, deleteReason);
      await logout();
      Get.offAllNamed('/main');
    } catch (e) {
      print('회원탈퇴 중 에러 발생: $e');
      CustomSnackBar.showErrorSnackBar(
          title: '회원탈퇴 실패', message: '다시 시도해주세요.');
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
      CustomSnackBar.showErrorSnackBar(message: '버전 조회 실패');
    }
  }

  /// 회원 차단 여부 확인
  Future<void> checkRejectUser() async {
    // 토큰이 유효한지 확인
    if (accessToken.value.isEmpty) {
      print('홈 화면 차단여부 조회 실패>>>>>>>>>>>>>>>>>>> 토큰 없음');
      return;
    }
    try {
      bool isReject = await authRepository.checkRejectUser(accessToken.value);
      if(isReject){
        isRejectUser.value = isReject;
        getRejectReason();
      }

    } catch (e) {
      print('회원 차단 확인 중 에러 발생: $e');
    }
  }

  /// 차단 사유 조회
  Future<void> getRejectReason() async {
    try {
      if (accessToken.value.isEmpty) {
        return;
      }

      final RejectReasonResponseModel response =
          await authRepository.getRejectReason(accessToken.value);

      rejectAdminName.value = response.adminName;
      rejectReason.value = response.reason;
    } catch (e) {
      print('차단 사유 조회 중 에러 발생: $e');
    }
  }

}

int _checkVersion(String appVersion, String minimumVersion) {
  List<int> appVersionList = appVersion.split('.').map(int.parse).toList();
  List<int> minimumVersionList =
      minimumVersion.split('.').map(int.parse).toList();

  for (int i = 0; i < appVersionList.length; i++) {
    if (appVersionList[i] > minimumVersionList[i]) return 1;
    if (appVersionList[i] < minimumVersionList[i]) return -1;
  }
  return 0;
}
