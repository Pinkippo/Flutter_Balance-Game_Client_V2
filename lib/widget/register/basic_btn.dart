import 'package:flutter/material.dart';
import 'package:yangjataekil/theme/app_color.dart';

class BasicBtn extends StatelessWidget {
  final String buttonText;

  const BasicBtn({Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.btnBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
