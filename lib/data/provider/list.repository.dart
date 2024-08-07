import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';
import 'package:yangjataekil/data/model/board/list_board_response_model.dart';
import 'package:yangjataekil/theme/app_color.dart';

import 'package:http/http.dart' as http;

final baseUrl = dotenv.env['BASE_URL'];

class ListRepository {
  Future<ListBoardResponseModel> getList(
      ListBoardRequestModel request, String token) async {
    final url = Uri.parse('$baseUrl/board/v2/boards');

    final response = await http.get(
      request.searching
          ? Uri.parse('$url?'
              'query=${request.query}&'
              'page=${request.page}&'
              'size=${request.size}&'
              'sortCondition=${request.sortCondition?.name ?? ''}&'
              'themeId=${request.themeId}&'
              // 'themeId=${request.themeId}&'
              )
          : Uri.parse('$url?'
              'page=${request.page}&'
              'size=${request.size}&'
              'sortCondition=${request.sortCondition?.name ?? ''}&'
              'themeId=${request.themeId}&'
              // 'themeId=${request.themeId}&'
              ),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // print('리스트 조회 응답: ${utf8.decode(response.bodyBytes)}');
    if (response.statusCode == 200) {
      print(request.query);
      return ListBoardResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      Get.snackbar(
        '조회 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to get');
    }
  }
}
