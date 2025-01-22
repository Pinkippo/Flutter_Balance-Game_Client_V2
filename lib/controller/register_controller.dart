import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/register_request_model.dart';
import 'package:yangjataekil/data/model/register_response_model.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

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
  final birthController = TextEditingController(
    text:
        "${DateTime.now().year.toString().padLeft(4, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
  );
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
      CustomSnackBar.showErrorSnackBar(
          title: '아이디 중복 확인', message: '아이디를 입력해주세요.');
      return;
    }

    try {
      final response =
          await authRepository.checkDuplicateAccountName(accountName.value);
      if (response) {
        CustomSnackBar.showErrorSnackBar(
            title: '아이디 중복 확인', message: '이미 사용중인 아이디입니다.');
      } else {
        CustomSnackBar.showSuccessSnackBar(
            title: '아이디 중복 확인', message: '사용 가능한 아이디입니다.');
        checkDuplicate.value = true;
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(
          title: '아이디 중복 확인', message: '아이디 중복 확인에 실패했습니다.');
    }
  }

  /// 이메일 인증 요청
  Future<void> requestEmailVerification() async {
    try {
      await authRepository.requestEmailAuth(email.value);
      isEmailSent.value = true;
      CustomSnackBar.showSnackBar(message: '이메일 인증 요청이 완료되었습니다.');
    } catch (e) {
      isEmailSent.value = false;
      CustomSnackBar.showErrorSnackBar(
          title: '이메일 인증 요청', message: '이메일 인증 요청에 실패했습니다.');
    }
  }

  /// 이메일 인증 확인
  Future<void> verifyEmail() async {
    try {
      await authRepository.verifyEmailAuth(email.value, emailAuthCode.value);
      CustomSnackBar.showSuccessSnackBar(message: '이메일 인증이 완료되었습니다.');
      isEmailVerified.value = true;
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(
          title: '이메일 인증', message: '이메일 인증에 실패했습니다.');
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
        selectedDate.value.toString() == '') {
      print('realName >> ${realName.value},'
          'email >> ${accountName.value},'
          'pw >> ${pw.value},'
          'pwChk >> ${pwChk.value},'
          'selectedDate >> ${selectedDate.value},');
      CustomSnackBar.showErrorSnackBar(
          title: '미입력 항목', message: '모든 항목을 입력해주세요.');
      return;
    }

    // 비밀번호 조건 확인 (영문 대문자/소문자, 숫자, 특수문자 중 2가지 이상 포함, 6~20자)
    const passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d|(?=.*[!@#\$&*~])).{6,20}$';
    final regex = RegExp(passwordPattern);

    if (!regex.hasMatch(pw.value)) {
      CustomSnackBar.showErrorSnackBar(
          title: '비밀번호 오류',
          message: '영문 대문자와 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 6~20자로 입력해주세요.');
      return;
    }

    // 비밀번호 일치 여부 확인
    if (pw.value != pwChk.value) {
      CustomSnackBar.showErrorSnackBar(
          title: '비밀번호 불일치', message: '비밀번호가 일치하지 않습니다.');
      return;
    }

    // 이메일 중복확인 체크
    if (!checkDuplicate.value) {
      CustomSnackBar.showErrorSnackBar(
          title: '아이디 중복 확인', message: '아이디 중복 확인을 해주세요.');
      return;
    }

    // 이메일 인증 확인 체크
    if (!isEmailVerified.value) {
      CustomSnackBar.showErrorSnackBar(
          title: '이메일 인증', message: '이메일 인증을 해주세요.');
      return;
    }

    // 중복 확인 완료 시 다음 페이지로 이동
    if (checkDuplicate.value && isEmailVerified.value) {
      Get.toNamed('/profile');
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

      /// TODO: 추후 생년월일, 푸쉬토큰 수정
      // birth: birthController.text,
      email: email.value,
      // pushToken: 'pushToken',
      isCheckedMarketing: false,
      profileUrl: profileUrl.value,
      nickName: nicknameOrNull,
    ));
    print('프로필url(controller): ${profileUrl.value}');

    if (response.accessToken.isNotEmpty) {
      await AuthController()
          .updateToken(response.accessToken, response.refreshToken);
      Get.offAllNamed('/login');
      CustomSnackBar.showSuccessSnackBar(
          title: '회원가입 성공', message: '회원가입에 성공했습니다.');
      return true;
    } else {
      CustomSnackBar.showErrorSnackBar(
          title: '회원가입 실패', message: '회원가입에 실패했습니다.');
      return false;
    }
  }
}
