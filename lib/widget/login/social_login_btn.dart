import 'package:flutter/material.dart';
import 'package:yangjataekil/controller/auth/login_controller.dart';

class SocialLoginBtn extends StatelessWidget {
  final LoginPlatform loginPlatform;

  const SocialLoginBtn({super.key, required this.loginPlatform});

  @override
  Widget build(BuildContext context) {
    String imagePath = '';
    VoidCallback clickBtn = () {}; // 기본 빈 함수 설정

    switch (loginPlatform) {
      case (LoginPlatform.google):
        imagePath = 'assets/images/login/google_icon.png';
        clickBtn = () => print('google로그인');
        break;

      case (LoginPlatform.kakao):
        imagePath = 'assets/images/login/kakao_icon.png';
        clickBtn = () => print('kakao로그인');
        break;

      case (LoginPlatform.apple):
        imagePath = 'assets/images/login/apple_icon.png';
        clickBtn = () => print('apple로그인');
        break;
    }

    return Stack(
      children: [
        Card(
          color: Colors.white,
          shape: CircleBorder(),
          child: Container(
            padding: loginPlatform == LoginPlatform.google ? EdgeInsets.all(11) : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                fit: BoxFit.cover,
                imagePath,
              ),
            ),
          ),
        ),
        Positioned.fill(
          // 부모 크기에 맞게 positioned.fill로 설정
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.3), // 클릭 시 버튼 효과 색상
              borderRadius: BorderRadius.circular(50), // 터치 부분도 radius 설정
              onTap: () {
                clickBtn();
              },
            ),
          ),
        ),
      ],
    );
  }
}
