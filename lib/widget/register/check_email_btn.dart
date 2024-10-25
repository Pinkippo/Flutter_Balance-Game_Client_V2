import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChkEmailBtn extends StatelessWidget {
  const ChkEmailBtn({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.color,
    required this.fontColor,
    required this.isEnabled,
  }) : super(key: key);

  final String title;

  final VoidCallback onPressed;

  final Color color;

  final Color fontColor;

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        onPressed: isEnabled ? onPressed : null,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.035, // 화면 크기에 따라 텍스트 크기 조정
              color: fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
