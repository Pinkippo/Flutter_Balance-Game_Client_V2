import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yangjataekil/data/model/game/game_detail_response_model.dart';
import 'package:yangjataekil/data/model/game/game_play_content_response_model.dart';
import 'package:yangjataekil/data/model/game/game_play_request_model.dart';
import 'package:yangjataekil/data/model/game/related_game_model.dart';
import 'package:yangjataekil/data/model/upload_game_request_model.dart';

import '../../theme/app_color.dart';

final baseUrl = dotenv.env['BASE_URL'];

class GameRepository {
  // 게임 등록
  Future<bool> uploadGame(
      UploadGameRequestModel uploadGameRequestModel, String token) async {
    final url = Uri.parse('$baseUrl/board/v2/board');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(uploadGameRequestModel.toJson()),
    );
    print('게임 등록:${response.statusCode}');

    if (response.statusCode == 200) {
      return true;
    } else {
      Get.snackbar(
        '게임 등록 실패',
        '다시 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to upload game');
    }
  }

  /// 게임 상세 조회
  Future<GameDetailResponseModel> getGameDetail(String boardId) async {
    final url = Uri.parse('$baseUrl/board/v2/public/boards/$boardId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      return GameDetailResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      Get.snackbar(
        '게임 상세 조회 실패',
        '다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      /// 뒤로가기
      Get.back();
      throw Exception('게임 상세 조회 실패');
    }
  }

  /// 관련 게임 조회
  Future<List<RelatedGameModel>> getRelatedGame(String boardId) async {
    final url =
        Uri.parse('$baseUrl/board/v2/boards/$boardId/related-boards');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      return body['boards']
          .map<RelatedGameModel>((item) => RelatedGameModel.fromJson(item))
          .toList();
    } else {
      Get.snackbar(
        '관련 게임 조회 실패',
        '다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      throw Exception('관련 게임 조회 실패');
    }
  }

  /// 게임 플레이 컨텐츠 조회
  Future<BoardContentResponse> getGameContent(String boardId, String token) async {
    final url = Uri.parse('$baseUrl/board/v2/boards/$boardId/contents');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint("body >>>> $body");
      return BoardContentResponse.fromJson(body);
    } else {
      Get.snackbar(
        '게임 컨텐츠 조회 실패',
        '다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      throw Exception('게임 목록 조회 실패');
    }
  }

  /// 게임 플레이 결과 전송
  Future<BoardContentResponse> postGameResult(String boardId, List<GamePlayRequestModel> selectedResult, String token) async {
    final url = Uri.parse('$baseUrl/board/v2/boards/$boardId/result');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(selectedResult.map((e) => e.toJson()).toList()),
    );
    if (response.statusCode == 200) {
      return BoardContentResponse.fromPostJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      Get.snackbar(
        '게임 결과 전송 실패',
        '다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      throw Exception('게임 결과 전송 실패');
    }
  }

  /// 게임 신고 메서드
  Future<bool> reviewReport(
      String token, int boardId, String content) async {
    final url = Uri.parse(
        '$baseUrl/board/v2/boards/$boardId/report');

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
      if (response.statusCode == 200) {
        return true;
      } else {
        throw HttpException('Failed to report review: ${response.statusCode}');
      }
    } catch (error) {
      print('Exception occurred: $error');
      rethrow;
    }
  }

}
