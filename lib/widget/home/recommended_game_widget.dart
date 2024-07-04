import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class RecommendedGame extends StatelessWidget {
  const RecommendedGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                '오늘의 추천 밸런스 게임',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 180,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black.withOpacity(0.13),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('병맛 밸런스 게임?\n궁금하면 들어와',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 15),
                Text(
                  '"나는 이상한(?)게임이 하고 싶다"\n"나는 말이 안 되는 질문이 좋다"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 68,
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      /// TODO : 화면이동 연결
                      print('게임하러 가기');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('게임하러 가기'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
