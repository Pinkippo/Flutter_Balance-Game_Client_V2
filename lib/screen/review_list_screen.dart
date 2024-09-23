import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/controller/report_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

import '../controller/review_controller.dart';
import '../widget/report/review_report_dialog_widget.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewController = Get.find<ReviewController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰 목록'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        color: Colors.white,
        child: Obx(() {
          if (reviewController.reviews.isEmpty) {
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
            itemCount: reviewController.reviews.length,
            itemBuilder: (context, index) {
              final review = reviewController.reviews[index];
              print('리뷰어 이미지 정보 : ${review.profile}');
              return Stack(
                children: [
                  Column(
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
                                    backgroundImage: review.profile.isNotEmpty
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
                  ),
                  AuthController.to.accessToken.value.isEmpty
                      ? const SizedBox.shrink()
                      : Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: () {
                              reviewController.boardReviewId.value =
                                  review.boardReviewId;
                              print(
                                  'boardReviewId: ${reviewController.boardReviewId.value}');
                              Get.dialog(
                                PopScope(
                                  onPopInvokedWithResult:
                                      (bool didPop, dynamic result) {
                                    reviewController.selectedCategory.value =
                                        null;
                                    reviewController.content.value = '';
                                  },
                                  child:
                                      reportDialog(context, reviewController, review.boardId),
                                ),
                              );
                            },
                            icon: const Icon(Icons.error_outline,
                                color: Colors.redAccent),
                          ),
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
