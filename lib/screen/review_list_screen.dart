import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yangjataekil/theme/app_color.dart';

import '../controller/review_list_controller.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int boardId = Get.arguments;
    final controller = Get.put(ReviewListController(boardId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰 목록'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        color: Colors.white,
        child: Obx(() {
          if (controller.reviews.isEmpty) {
            return const Center(
              child: Text(
                '리뷰가 없습니다.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.reviews.length,
            itemBuilder: (context, index) {
              final review = controller.reviews[index];
              return Column(
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
                              padding: const EdgeInsets.fromLTRB(5, 8, 0, 0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[300],
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: ListTile(
                            /// 닉네임
                            title: Text(
                              review.nickName,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),

                            /// 키워드, 리뷰 제목, 내용
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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

                            /// 좋아요 or 싫어요 아이콘
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
              );
            },
          );
        }),
      ),
    );
  }
}
