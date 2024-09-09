import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yangjataekil/controller/report_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

import '../controller/review_list_controller.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewController = Get.find<ReviewListController>();
    final reportController = Get.find<ReportController>();

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
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        reportController.boardReviewId.value =
                            review.boardReviewId;
                        print(
                            'boardReviewId: ${reportController.boardReviewId.value}');
                        Get.dialog(
                          PopScope(
                            onPopInvokedWithResult:
                                (bool didPop, dynamic result) {
                              reportController.selectedCategories.value = '';
                              reportController.content.value = '';
                            },
                            child: reportDialog(reportController),
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

  Widget reportDialog(ReportController reportController) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '리뷰 신고',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),

            /// 신고 사유 선택
            Obx(() {
              return DropdownButtonFormField2(
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                hint: const Text(
                  '신고 사유를 선택해주세요.',
                  style: TextStyle(fontSize: 14),
                ),
                items: reportController.categories
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return '신고 사유를 선택';
                  }
                  return null;
                },
                onChanged: (value) {
                  reportController.selectedCategories.value = value!;
                },
                value: reportController.selectedCategories.value.isEmpty
                    ? null
                    : reportController.selectedCategories.value,
                decoration: const InputDecoration(
                  // 드롭다운메뉴 클릭 전 테두리 색상
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  // 드롭다운메뉴 클릭 시 테두리 색상
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                  hintText: '신고 사유를 선택해주세요.',
                ),
              );
            }),

            const SizedBox(height: 10),

            /// 기타 선택 시 신고 내용 입력 필드 보여주기
            Obx(() {
              if (reportController.selectedCategories == '기타') {
                return TextField(
                  maxLines: 5,
                  maxLength: 100,
                  onChanged: (value) {
                    reportController.updateContent(value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: '신고 내용을 입력해주세요.',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink(); // 아무것도 출력하지 않음
              }
            }),

            const SizedBox(height: 30),

            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: const Text(
                      '신고',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    onTap: () {
                      reportController
                          .reviewReport(reportController.boardReviewId.value,
                              reportController.content.value)
                          .then((value) {
                        if (value) {
                          Get.snackbar(
                            '신고 완료',
                            '신고가 정상적으로 접수되었습니다!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          Get.snackbar(
                            '신고 실패',
                            '신고 접수에 오류가 생겼습니다.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      });
                      Get.back();
                    },
                  ),
                  const VerticalDivider(
                    thickness: 1.5,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
