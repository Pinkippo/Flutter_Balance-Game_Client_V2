import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/model/board/list_board_request_model.dart';
import 'package:yangjataekil/data/model/board/list_board_response_model.dart';
import 'package:yangjataekil/data/model/board/recommend_board_response_model.dart';
import 'package:yangjataekil/theme/app_color.dart';

import 'package:http/http.dart' as http;

final baseUrl = dotenv.env['BASE_URL'];

class ListRepository {
  Future<ListBoardResponseModel> getList(
      ListBoardRequestModel request, String token) async {
    final url = Uri.parse('$baseUrl/board/v2/boards');

    print('query=${request.query}&'
        'page=${request.page}&'
        'size=${request.size}&'
        'sortCondition=${request.sortCondition?.name ?? ''}&'
        'themeId=${request.themeId}&');
    final response = await http.get(
      request.searching
          ? (request.themeId == null
              ? Uri.parse('$url?'
                  'query=${request.query}&'
                  'page=${request.page}&'
                  'size=${request.size}&'
                  'sortCondition=${request.sortCondition?.name ?? ''}&')
              : Uri.parse('$url?'
                  'query=${request.query}&'
                  'page=${request.page}&'
                  'size=${request.size}&'
                  'sortCondition=${request.sortCondition?.name ?? ''}&'
                  'themeId=${request.themeId}&'))
          : request.themeId == null
              ? Uri.parse('$url?'
                  'page=${request.page}&'
                  'size=${request.size}&'
                  'sortCondition=${request.sortCondition?.name ?? ''}&')
              : Uri.parse('$url?'
                  'page=${request.page}&'
                  'size=${request.size}&'
                  'sortCondition=${request.sortCondition?.name ?? ''}&'
                  'themeId=${request.themeId}&'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        if(token.isNotEmpty)
          'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print(decodedResponse);
      print('테마별 조회 리스트 갯수: ${decodedResponse['boards']['boards'].length}');
      return ListBoardResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      print('게임 리스트 조회 실패(repository)');
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

  /// 오늘의 추천 게임 조회 API
  Future<RecommendBoardResponseModel> getRecommendList() async {
    final url = Uri.parse('$baseUrl/board/v2/boards/today-recommend-game');

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );

    if (response.statusCode == 200) {
      // print('오늘의 추천 게시글 조회 응답: ${utf8.decode(response.bodyBytes)}');
      return RecommendBoardResponseModel.fromJson(
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

  /// 내 게임 리스트 조회
  Future<ListBoardResponseModel> getMyGames(String token) async {
    final url = Uri.parse('$baseUrl/board/v2/boards/me');

    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print('내 게임 리스트 조회 response: ${utf8.decode(response.bodyBytes)}');
      return ListBoardResponseModel.fromJsonForMyBoard(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      print('내 게임 리스트 조회 실패');
      Get.snackbar(
        '조회 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception('내 게임 리스트 조회 실패');
    }
  }
}
