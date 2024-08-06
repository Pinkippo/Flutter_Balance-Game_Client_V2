import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/user_modify_controller.dart';

class ModifyNicknameInputField extends GetView<UserModifyController> {
  const ModifyNicknameInputField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.textController,
  }) : super(key: key);

  final String hintText;

  final bool obscureText;

  final TextEditingController textController;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onChanged: (value) {
        controller.updateNickname(value);
      },
      style: const TextStyle(
        fontSize: 16,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.grey,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffFF9297)))),
    );
  }
}
