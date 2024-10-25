import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/data/model/notice_response_model.dart';
import 'package:http/http.dart' as http;

import '../model/notice_detail_response_model.dart';

final baseUrl = dotenv.env['BASE_URL'];

class NoticeRepository {
  /// 공지사항 조회
  Future<NoticeResponseModel> getNotice(String searchCondition) async {
    final url = Uri.parse('$baseUrl/common/v2/announcements');

    final response = await http.get(
      Uri.parse('$url?'
          'searchCondition=$searchCondition&'),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );
    print('공지사항 조회 응답: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      print('공지사항 조회 API response : \n${utf8.decode(response.bodyBytes)}');
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData is Map<String, dynamic>) {
        return NoticeResponseModel.fromJson(responseData);
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('공지사항 조회 실패');
    }
  }

  Future<NoticeDetailResponseModel> getNoticeDetail(int announcementId) async {
    final url = Uri.parse('$baseUrl/common/v2/announcements/$announcementId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );

    if (response.statusCode == 200) {
      print('공지사항 상세 조회 API response : \n${utf8.decode(response.bodyBytes)}');

      final responseData = jsonDecode(utf8.decode(response.bodyBytes));

      if (responseData is Map<String, dynamic>) {
        return NoticeDetailResponseModel.fromJson(responseData);
      } else {
        print('변환 에러');
        throw Exception('transfer error');
      }
    } else {
      throw Exception('Unexpected response format');
    }
  }
}
