import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yangjataekil/data/model/register_response_model.dart';
import 'package:yangjataekil/data/model/user_response_model.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:http/http.dart' as http;

import '../model/register_request_model.dart';

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
    // print('회원 조회 응답: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      print('회원조회 API response : \n${utf8.decode(response.bodyBytes)}');
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData is Map<String, dynamic>) {
        return UserResponseModel.fromJson(responseData);
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('회원 조회 실패');
    }
  }

  // 회원가입
  Future<RegisterResponseModel> register(
      RegisterRequestModel registerRequestModel) async {
    final url = Uri.parse('$baseUrl/user/v2/sign-up');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(registerRequestModel.toJson()),
    );
    print('회원가입 body:\n${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      Get.snackbar(
        '회원가입 실패',
        '다시 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      throw Exception('Failed to register');
    }
  }

  // 이메일 중복 확인
  Future<bool> checkDuplicateAccountName(String accountName) async {
    final url = Uri.parse('$baseUrl/user/v2/check-account-name');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
      body: jsonEncode({'accountName': accountName}),
    );

    print('입력한 아이디: $accountName');
    print('Response Status Code: ${response.statusCode}');
    print('아이디 중복 확인 응답: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        throw Exception('서버 응답이 비어 있습니다');
      }
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('isExist')) {
        return responseData['isExist'];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('아이디 중복 확인 실패');
    }
  }

  // 프로필 이미지 업로드
  Future<String> uploadProfileImage(XFile image) async {
    final url = Uri.parse('$baseUrl/user/v2/profile');
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', image.path,
          contentType: MediaType('image', 'jpeg')));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    print('프로필 이미지 업로드 응답: $responseBody');

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('이미지 업로드 실패');
    }
  }

  // 이메일 인증 요청
  Future<bool> requestEmailAuth(String email) async {
    final url = Uri.parse('$baseUrl/user/v2/email-certificate');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
      body: jsonEncode({'email': email}),
    );

    print('이메일 인증 요청 응답: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('이메일 인증 요청 실패');
    }
  }

  // 이메일 인증 확인
  Future<bool> verifyEmailAuth(String email, String code) async {
    final url = Uri.parse('$baseUrl/user/v2/check-email-certificate');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
      body: jsonEncode({'email': email, 'code': code}),
    );

    print('이메일 인증 확인 응답: ${utf8.decode(response.bodyBytes)}');

    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));

    if (responseBody['isConfirm'] == true) {
      return true;
    } else {
      throw Exception('이메일 인증 확인 실패');
    }
  }
}
