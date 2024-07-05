import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/theme/app_color.dart';

import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import 'package:http/http.dart' as http;

final baseUrl = dotenv.env['BASE_URL'];

class LoginRepository {
  // 로그인
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    final url = Uri.parse('$baseUrl/user/v2/sign-in');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginRequestModel.toJson()),
    );
    print('로그인 요청 응답: ${utf8.decode(response.bodyBytes)}');
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else if (response.statusCode != 200) {
      Get.snackbar(
        '아이디 혹은 비밀번호가 일치하지 않습니다.',
        '다시 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to login');
    } else {
      Get.snackbar(
        '로그인 실패',
        '서버 상태가 불안정합니다. 잠시 후 다시 시도해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to login');
    }
  }
}