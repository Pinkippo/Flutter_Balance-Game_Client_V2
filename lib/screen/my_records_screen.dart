import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyRecordsScreen extends StatelessWidget {
  const MyRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '내 활동',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Divider(height: 1, color: Colors.grey[300]),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// 바디 헤더 텍스트 부분
          Container(
            alignment: Alignment.center, // 텍스트를 가운데 정렬
            padding: const EdgeInsets.symmetric(horizontal: 16), // 좌우 여백 추가
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '이곳에서 내 활동을 관리해보세요',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                ),
                SizedBox(height: 10),
                Text(
                  '회원님의 콘텐츠 활동을 확인하고 관리할 수 있습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                  softWrap: true, // 텍스트가 자연스럽게 줄바꿈 되도록 설정
                  overflow: TextOverflow.visible, // 오버플로우 처리
                ),
              ],
            ),
          ),

          /// 리스트 부분
          Container(
            padding: const EdgeInsets.fromLTRB(23, 16, 20, 0),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.sports_esports_outlined,
                      color: Colors.black),
                  title: const Text('내 게임'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.black.withOpacity(0.5),
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    // '내 게임' 클릭 시 동작 추가
                    print('내 게임 클릭');
                  },
                ),
                // 내가 참여한 게임
                ListTile(
                  leading:
                      const Icon(Icons.restore_outlined, color: Colors.black),
                  title: const Text('내가 참여한 게임'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.black.withOpacity(0.5),
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    // '내가 참여한 게임' 클릭 시 동작 추가
                    print('내가 참여한 게임 클릭');
                  },
                ),
                // 내가 작성한 리뷰
                ListTile(
                  leading: const Icon(Icons.rate_review_outlined,
                      color: Colors.black),
                  title: const Text('내가 작성한 리뷰'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.black.withOpacity(0.5),
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    /// 내가 작성한 리뷰 리스트 페이지
                    Get.toNamed('/my_reviews');
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 5,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
    );
  }
}
