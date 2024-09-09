import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:yangjataekil/data/model/review_request_model.dart';

final baseUrl = dotenv.env['BASE_URL'];

class ReviewRepository {
  /// 리뷰 작성
  Future<void> uploadReview(String token, int boardId,
      ReviewRequestModel reviewRequestModel) async {
    final url = Uri.parse('$baseUrl/board/v2/boards/$boardId/review');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization' : 'Bearer $token',
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
      body: jsonEncode(reviewRequestModel.toJson()),
    );
    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    print('리뷰작성 response: ${(utf8.decode(response.bodyBytes))}');

    if(responseBody['code'] == "NOT_SIGNED_GAME_ERROR") {
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

    }
  }
}
