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
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else if (response.statusCode == 400) {
      if(responseData['code'] == 'NOT_SIGN_UP_USER_ERROR'){
        throw Exception('NOT_SIGN_UP_USER_ERROR');
      } else if (responseData['code'] == 'PASSWORD_MISMATCH_ERROR') {
        throw Exception('PASSWORD_MISMATCH_ERROR');
      } else {
        throw Exception('Failed to login');
      }
    } else {
      throw Exception('Failed to login');
    }
  }
}
