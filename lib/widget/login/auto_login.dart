import 'package:flutter/material.dart';

/// 자동 로그인 체크박스 위젯

class AutoLogin extends StatefulWidget {
  const AutoLogin({Key? key}) : super(key: key);

  @override
  _AutoLoginState createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
  bool _autoLogin = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _autoLogin,
          onChanged: (value) {
            setState(() {
              _autoLogin = value!;
            });
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          side: const BorderSide(color: Color(0xffD1D1D1)),
          activeColor: const Color(0xffFF9297),
        ),
        const SizedBox(width: 5),
        const Text('자동 로그인'),
      ],
    );
  }
}
