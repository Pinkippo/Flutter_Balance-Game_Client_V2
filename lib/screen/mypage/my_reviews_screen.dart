import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/review_controller.dart';

class MyReviewsScreen extends GetView<ReviewController> {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          '작성 리뷰',
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
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: controller.getMyReviewList(), // 비동기 작업 호출
          builder: (context, snapshot) {
            // 로딩 중일 때 로딩 인디케이터 표시
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // 오류가 발생했을 때
            else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  '리뷰를 불러오는 중 오류가 발생했습니다.',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            }
            // 데이터가 성공적으로 로드되었을 때
            else {
              return Obx(() {
                // 만약 리뷰가 비어있다면
                if (controller.myReviews.isEmpty) {
                  return const Center(
                    child: Text(
                      '작성한 리뷰가 없습니다.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                // 리뷰 리스트가 있을 경우
                return ListView.builder(
                  itemCount: controller.myReviews.length,
                  itemBuilder: (context, index) {
                    final review = controller.myReviews[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/game_detail',
                            arguments: {'boardId': review.boardId.toString()});
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 13, 0, 13),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 8, 0, 0),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.grey[300],
                                        backgroundImage: review
                                                .profile.isNotEmpty
                                            ? NetworkImage(review.profile)
                                                as ImageProvider
                                            : const AssetImage(
                                                'assets/images/game/profile_img.png'),
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: ListTile(
                                    title: Text(
                                      review.nickName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '#${review.keywords.join('  #')}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '"${review.title}"',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          review.comment,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (review.isLike)
                                          const FaIcon(
                                            FontAwesomeIcons.thumbsUp,
                                            color: Colors.blue,
                                          ),
                                        if (review.isDislike)
                                          const FaIcon(
                                            FontAwesomeIcons.thumbsDown,
                                            color: Colors.red,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 2,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    );
                  },
                );
              });
            }
          },
        ),
      ),
    );
  }
}
