import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
}
