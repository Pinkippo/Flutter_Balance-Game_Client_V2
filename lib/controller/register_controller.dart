import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// 회원가입 컨트롤러
class RegisterController extends GetxController {
  /// 회원가입 폼 키
  final formKey = GlobalKey<FormState>();

  /// 이름
  final Rx<String> userName = ''.obs;

  /// 이메일
  final Rx<String> email = ''.obs;

  /// 비밀번호
  final Rx<String> pw = ''.obs;

  /// 비밀번호 확인
  final Rx<String> pwChk = ''.obs;

  /// 생년월일
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  /// 전화번호
  final Rx<String> phone = ''.obs;

  /// 닉네임
  final Rx<String> nickname = ''.obs;

  /// 프로필 사진
  final Rx<XFile?> profile = Rx<XFile?>(null);

  final emailController = TextEditingController();
  final birthController = TextEditingController();
  final nicknameController = TextEditingController();

  void updateUserName(String userName) {
    this.userName.value = userName;
    print('UserName >> $userName');
  }

  /// 비밀번호 변경
  void updateEmail(String email) {
    this.email.value = email;
    print('Email >> $email');
  }

  void updatePw(String pw) {
    this.pw.value = pw;
    print('Pw >> $pw');
  }

  /// 비밀번호 변경
  void updatePwChk(String pwChk) {
    this.pwChk.value = pwChk;
    print('PwChk >> $pwChk');
  }

  /// 날짜 변경
  void updateBirth(DateTime date) {
    selectedDate.value = date;
    birthController.text =
        "${date.year.toString().padLeft(4, '0')}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
    print('Birth >> $selectedDate');
  }

  /// 비밀번호 변경
  void updatePhone(String phone) {
    this.phone.value = phone;
    print('Phone >> $phone');
  }

  void clearEmail() {
    email.value = '';
    emailController.clear();
    print('email >> $email');
  }

  void updateProfile(XFile image) {
    profile.value = image;
    print('profile >> $profile');
  }

  void updateNickname(String nickname) {
    this.nickname.value = nickname;
    print('nickname >> $nickname');
  }
}
