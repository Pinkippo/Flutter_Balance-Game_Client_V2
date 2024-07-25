import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/register_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class EmailInputField extends GetView<RegisterController> {
  const EmailInputField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.textController,
    required this.icon,
  }) : super(key: key);

  final String hintText;
  final bool obscureText;
  final TextEditingController textController;
  final Icon icon;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      onChanged: (value) {
        controller.updateAccountName(value);
      },
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: AppColors.btnBackgroundColor, width: 0.5),
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
