import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

/// 홈 화면 상단 위젯
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.secondaryColor,
      height: screenHeight * 0.25, // 높이를 화면 높이의 25%로 설정
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                // color: Colors.white,
                width: screenWidth * 0.5, // 너비를 화면 너비의 50%로 설정
                height: 55,
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: const Text(
                  '첫 의견 남기고 5000원\n받아가세요 어쩌고~!',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                // color: Colors.white,
                width: screenWidth * 0.5, // 너비를 화면 너비의 50%로 설정
                height: 55,
                margin: const EdgeInsets.only(left: 20, top: 5),
                child: Text(
                  '질문만 만들어도 어쩌고 저쩌고\n포인트가 쑥쑥!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.white,
            width: screenWidth * 0.35, // 너비를 화면 너비의 35%로 설정
            height: screenWidth * 0.35, // 높이를 화면 너비의 35%로 설정
            margin: const EdgeInsets.only(right: 20, top: 10),
            child: Image.asset('assets/images/home_img.png'),
          ),
        ],
      ),
    );
  }
}
