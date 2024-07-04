import 'package:flutter/material.dart';

/// 사용자 리뷰 위젯

class UserReview extends StatelessWidget {
  const UserReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '사용자 리뷰로 확인해보자!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  /// TODO : 화면이동 연결
                  print('사용자 리뷰 더보기 클릭');
                },
                child: Text('더보기 ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.5),
                      decoration: TextDecoration.underline,
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

      ],
    );
  }
}
