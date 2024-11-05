import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/recommend_controller.dart';

/// 사용자 리뷰 위젯

class UserReview extends GetView<RecommendController> {
  const UserReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '사용자 리뷰로 확인해보자!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        /// 추천 리뷰 리스트
        Obx(
          () => SizedBox(
            height: 230,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount: controller.recommendedReviews.length,
              itemBuilder: (context, index) {
                final review = controller.recommendedReviews[index];
                return Padding(
                  padding: EdgeInsets.only(right: index == 4 ? 0 : 10),
                  // 마지막 아이템은 오른쪽 패딩 없음
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(10),
                        width: 240,
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            /// 게임 상세 페이지로 이동
                            Get.toNamed('/game_detail', arguments: {
                              'boardId': review.boardId.toString(),
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 24, 12, 15),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[300],
                                            // child: const Icon(
                                            //   Icons.person,
                                            //   size: 20,
                                            //   color: Colors.grey,
                                            // ),
                                            backgroundImage: review
                                                    .profile.isNotEmpty
                                                ? NetworkImage(review.profile)
                                                    as ImageProvider
                                                : const AssetImage(
                                                    'assets/images/game/profile_img.png'),
                                          ),
                                        ),
                                        const SizedBox(width: 7),
                                        Text(
                                          review.nickName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        FontAwesomeIcons.thumbsUp,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  review.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  review.comment,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -10,
                        left: 20,
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Image.asset(
                            'assets/images/game/".png',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
