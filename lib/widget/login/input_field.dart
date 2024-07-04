import 'package:flutter/material.dart';

import '../../controller/login_controller.dart';

/// 로그인 화면의 텍스트 폼 필드 위젯

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.loginController,
  }) : super(key: key);

  /// 힌트 텍스트
  final String hintText;

  /// 비밀번호 여부
  final bool obscureText;

  /// 로그인 컨트롤러
  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (hintText == '아이디') {
          loginController.updateUserId(value);
        } else {
          loginController.updateUserPw(value);
        }
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Color(0xffFF9297), width: 0.5),
        ),
      ),
    );
  }
}
