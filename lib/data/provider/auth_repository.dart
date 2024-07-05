import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yangjataekil/data/model/user_response_model.dart';

import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import 'package:http/http.dart' as http;

final baseUrl = dotenv.env['BASE_URL'];

class AuthRepository {
  // 회원 조회
  Future<UserResponseModel> getUserInfo(String token) async {
    final url = Uri.parse('$baseUrl/user/v2/users/me');
    // 서버에서 회원 정보를 조회하는 코드
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    print('회원 조회 응답: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      return UserResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('회원 조회 실패');
    }
  }
}
