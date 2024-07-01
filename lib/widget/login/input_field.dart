import 'package:flutter/material.dart';

/// 로그인 화면의 텍스트 폼 필드 위젯

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  }) : super(key: key);

  /// 힌트 텍스트
  final String hintText;

  /// 비밀번호 여부
  final bool obscureText;

  /// 컨트롤러
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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