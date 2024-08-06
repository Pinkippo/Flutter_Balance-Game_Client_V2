import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/register_request_model.dart';
import 'package:yangjataekil/data/model/register_response_model.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';
import 'package:yangjataekil/theme/app_color.dart';

// 회원가입 컨트롤러
class RegisterController extends GetxController {
  /// RegisterRepository 인스턴스 생성
  final AuthRepository authRepository = AuthRepository();

  /// 회원가입 폼 키
  final formKey = GlobalKey<FormState>();

  /// 이름
  final Rx<String> realName = ''.obs;

  /// 아이디
  final Rx<String> accountName = ''.obs;

  /// 비밀번호
  final Rx<String> pw = ''.obs;

  /// 비밀번호 확인
  final Rx<String> pwChk = ''.obs;

  /// 생년월일
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  /// 이메일
  final Rx<String> email = ''.obs;

  /// 이메일 인증 요청 상태
  final Rx<bool> isEmailSent = false.obs;

  /// 이메일 인증 확인 상태
  final Rx<bool> isEmailVerified = false.obs;

  /// 이메일 인증 코드
  final Rx<String> emailAuthCode = ''.obs;

  /// 닉네임
  final Rx<String> nickname = ''.obs;

  /// 프로필 사진
  final Rx<XFile?> profile = Rx<XFile?>(null);

  /// 프로필 사진 URL
  final Rx<String> profileUrl = ''.obs;

  /// 아이디 중복 확인 상태
  final Rx<bool> checkDuplicate = false.obs;


  /// 텍스트 컨트롤러
  final accountNameController = TextEditingController();
  final birthController = TextEditingController();
  final nicknameController = TextEditingController();

  /// 이름 변경
  void updateUserName(String realName) {
    this.realName.value = realName;
    print('UserName >> $realName');
  }

  /// 아이디 변경
  void updateAccountName(String accountName) {
    this.accountName.value = accountName;
    checkDuplicate.value = false; // 아이디 변경 시 중복 확인 여부 초기화
    print('accountName >> $accountName');
  }

  /// 비밀번호 변경
  void updatePw(String pw) {
    this.pw.value = pw;
    print('Pw >> $pw');
  }

  /// 비밀번호 확인란 변경
  void updatePwChk(String pwChk) {
    this.pwChk.value = pwChk;
    print('PwChk >> $pwChk');
  }

  /// 날짜 변경
  void updateBirth(DateTime date) {
    selectedDate.value = date;
    birthController.text =
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    print('Birth >> ${birthController.text}');
  }

  /// 이메일 변경
  void updateEmail(String email) {
    this.email.value = email;
    print('email >> $email');
  }

  /// 아이디 초기화
  void clearEmail() {
    accountName.value = '';
    accountNameController.clear();
    checkDuplicate.value = false; // 이메일 초기화 시 중복 확인 여부 초기화
    print('ID >> $accountName');
  }

  /// 이메일 인증 코드 입력
  void updateEmailAuthCode(String code) {
    emailAuthCode.value = code;
    print('emailAuthCode >> $code');
  }

  /// 닉네임 입력
  void updateNickname(String nickname) {
    this.nickname.value = nickname;
    print('nickname >> $nickname');
  }

  /// 프로필 사진 업데이트
  void updateProfile(XFile image) {
    profile.value = image;
    print('profile 사진 랜더링 완료');
  }

  /// 아이디 중복 확인
  void checkDuplicateAccountName() async {
    if (accountName.value == '') {
      Get.snackbar('아이디 중복 확인', '아이디를 입력해주세요.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final response =
          await authRepository.checkDuplicateAccountName(accountName.value);
      if (response) {
        Get.snackbar('아이디 중복 확인', '이미 사용중인 아이디입니다..',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('아이디 중복 확인', '사용 가능한 아이디입니다..',
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        checkDuplicate.value = true;
      }
    } catch (e) {
      Get.snackbar('오류', e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// 이메일 인증 요청
  Future<void> requestEmailVerification() async {
    try {
      await authRepository.requestEmailAuth(email.value);
      isEmailSent.value = true;
      Get.snackbar('이메일 인증', '인증 이메일이 전송되었습니다.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      isEmailSent.value = false;
      Get.snackbar('오류', '이메일 인증 요청에 실패했습니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// 이메일 인증 확인
  Future<void> verifyEmail() async {
    try {
      await authRepository.verifyEmailAuth(email.value, emailAuthCode.value);
      Get.snackbar('이메일 인증', '인증이 완료되었습니다.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      isEmailVerified.value = true;
    } catch (e) {
      Get.snackbar('오류', '이메일 인증에 실패했습니다.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      isEmailVerified.value = false;
    }
  }

  /// 중복확인 시 다음페이지 이동 가능
  void nextStep() async {
    // 모든 항목이 입력되었는지 확인
    if (realName.value == '' ||
        accountName.value == '' ||
        pw.value == '' ||
        pwChk.value == '' ||
        selectedDate.value == null) {
      print('realName >> ${realName.value},'
          'email >> ${accountName.value},'
          'pw >> ${pw.value},'
          'pwChk >> ${pwChk.value},'
          'selectedDate >> ${selectedDate.value},');
      Get.snackbar('미입력 항목', '모든 항목을 입력해주세요.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // 비밀번호 일치 여부 확인
    if (pw.value != pwChk.value) {
      Get.snackbar('비밀번호 불일치', '비밀번호가 일치하지 않습니다.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // 이메일 중복확인 체크
    if (checkDuplicate.value) {
      Get.toNamed('/profile');
    } else {
      Get.snackbar('아이디 중복 확인', '아이디 중복을 확인해주세요.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // 이메일 인증 확인 체크
    if (isEmailVerified.value) {
      Get.toNamed('/profile');
    } else {
      Get.snackbar('이메일 인증', '이메일 인증을 완료해주세요.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
  }

  /// 닉네임을 반환하는 getter
  String? get nicknameOrNull => nickname.value.isEmpty ? null : nickname.value;

  /// 회원가입
  Future<bool> register() async {
    final RegisterResponseModel response =
        await authRepository.register(RegisterRequestModel(
      accountName: accountName.value,
      password: pw.value,
      realName: realName.value,
      birth: birthController.text,
      email: email.value,
      pushToken: 'pushToken',
      isCheckedMarketing: false,
      profileUrl: profileUrl.value,
      nickName: nicknameOrNull,
    ));
    print('프로필url: ${profileUrl.value}');

    if (response.accessToken.isNotEmpty) {
      await AuthController()
          .updateToken(response.accessToken, response.refreshToken);
      Get.snackbar(
        '회원가입 성공',
        '회원가입이 완료되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      Get.offAllNamed('/login');
      return true;
    } else {
      Get.snackbar(
        '회원가입 실패',
        '다시 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      return false;
    }
  }
}
