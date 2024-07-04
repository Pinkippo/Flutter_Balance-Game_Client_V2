import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/register_controller.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find();
    return TextFormField(
      onChanged: (value) {
        controller.updateEmail(value);
      },
      controller: this.controller,
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
          padding: EdgeInsets.zero,
          child: IconButton(
            icon: icon,
            onPressed: () {
              controller.clearEmail();
            },
          ),
        ),
      ), // Use initialValue instead of TextEditingController
    );
  }
}
