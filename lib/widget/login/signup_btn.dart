import 'package:flutter/material.dart';

/// 회원가입 버튼 위젯

class SignUpBtn extends StatelessWidget {
  const SignUpBtn({Key? key, required this.onPressed}) : super(key: key);

  /// 버튼 클릭 시 이벤트
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: const Text('회원가입', style: TextStyle(fontSize: 16, color: Colors.black54)),
      ),
    );
  }
}
