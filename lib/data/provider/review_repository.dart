import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:yangjataekil/data/model/review_request_model.dart';

import '../model/review_response_model.dart';

final baseUrl = dotenv.env['BASE_URL'];

/// 리뷰 레포지토리
class ReviewRepository {

  /// 리뷰 작성
  Future<void> uploadReview(
      String token, int boardId, ReviewRequestModel reviewRequestModel) async {
    final url = Uri.parse('$baseUrl/board/v2/boards/$boardId/review');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
      body: jsonEncode(reviewRequestModel.toJson()),
    );
    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    print('리뷰작성 response: ${(utf8.decode(response.bodyBytes))}');

    if (responseBody['code'] == "NOT_SIGNED_GAME_ERROR") {
      Get.dialog(AlertDialog(
        title: Text('로그인'),
        content: Text('로그인 후 이용해주세요.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('확인'),
          ),
        ],
      ));
    } else {
      if (response.statusCode == 200) {
        Get.snackbar('리뷰 작성 성공', '리뷰가 작성되었습니다.');
      } else {
        Get.snackbar('리뷰 작성 실패', '다시 시도해주세요.');
        throw Exception('Failed to upload review');
      }
    }
  }

  /// 리뷰 리스트 조회
  Future<ReviewResponseModel> getReviewList(String token, int boardId) async {
    final url = Uri.parse('$baseUrl/board/v2/public/boards/$boardId/reviews');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );

    if (response.statusCode == 200) {
      print('리뷰 리스트 조회 API response : \n${utf8.decode(response.bodyBytes)}');
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData is Map<String, dynamic>) {
        return ReviewResponseModel.fromJson(responseData);
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('리뷰 리스트 조회 실패');
    }
  }

  /// 리뷰 신고 메서드
  Future<bool> reviewReport(
      String token, int boardId, int boardReviewId, String content) async {
    final url = Uri.parse(
        '$baseUrl/board/v2/boards/$boardId/reviews/$boardReviewId/report');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'utf-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'content': content}),
      );

      print('(api)response : $boardReviewId');
      print('(api)response : $content');
      if (response.statusCode == 200) {
        print('(api)유저 신고 성공');
        return true;
      } else {
        print('(api)유저 신고 실패!');
        throw HttpException('Failed to report review: ${response.statusCode}');
      }
    } catch (error) {
      // 여기서 추가적인 예외 처리를 할 수 있습니다.
      print('Exception occurred: $error');
      rethrow; // 예외를 다시 던져서 컨트롤러에서 처리할 수 있게 합니다.
    }
  }
}
