import 'package:flutter/material.dart';
import 'package:yangjataekil/theme/app_thene.dart';

/// 로그인 버튼 위젯

class ChkEmailBtn extends StatelessWidget {
  const ChkEmailBtn({Key? key, required this.onPressed}) : super(key: key);

  /// 버튼 클릭 시 이벤트
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffE5E5E5),
          // backgroundColor: appThemeData.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: const Text('중복확인', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
