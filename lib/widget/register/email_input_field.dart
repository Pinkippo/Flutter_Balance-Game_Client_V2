import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yangjataekil/controller/register_controller.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  /// 힌트 텍스트
  final String hintText;

  /// 비밀번호 여부
  final bool obscureText;

  /// 컨트롤러
  final RegisterController controller;

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        controller.updateUserName(value);
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
        suffixIcon: Container(
          decoration: const BoxDecoration(
            color: Colors.grey, // 배경색 지정
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
      ),
    );
  }
}
