import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yangjataekil/controller/register_controller.dart';

class BasicInputField extends StatelessWidget {
  const BasicInputField({
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
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (hintText == '이름') {
          controller.updateUserName(value);
        } else if (hintText == '비밀번호') {
          controller.updatePw(value);
        } else if (hintText == '비밀번호 확인') {
          controller.updatePwChk(value);
        }
      },
      style: const TextStyle(
        fontSize: 15,
      ),
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
