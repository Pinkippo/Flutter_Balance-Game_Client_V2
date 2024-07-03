import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 회원가입 컨트롤러
class RegisterController extends GetxController {

  /// 회원가입 폼 키
  final formKey = GlobalKey<FormState>();

  /// 이름
  final RxString userName = ''.obs;

  /// 이메일
  final RxString email = ''.obs;

  /// 비밀번호
  final RxString pw = ''.obs;

  /// 비밀번호 확인
  final RxString pwChk = ''.obs;

  /// 생년월일
  final RxString birth = ''.obs;

  /// 전화번호
  final RxString phone = ''.obs;

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

  void updateBirth(String birth) {
    this.birth.value = birth;
    print('Birth >> $birth');
  }

  /// 비밀번호 변경
  void updatePhone(String phone) {
    this.phone.value = phone;
    print('Phone >> $phone');
  }

}