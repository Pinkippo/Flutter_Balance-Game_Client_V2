import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yangjataekil/data/model/review_response_model.dart';

final baseUrl = dotenv.env['BASE_URL'];

class ReviewListRepository {
  /// 리뷰 리스트 조회
  Future<ReviewResponseModel> getReviewList(String token, int boardId) async {
    final url = Uri.parse('$baseUrl/board/v2/public/boards/$boardId/reviews');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );

    if (response.statusCode == 200) {
      print('리뷰 리스트 조회 API response : \n${utf8.decode(response.bodyBytes)}');
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData is Map<String, dynamic>) {
        return ReviewResponseModel.fromJson(responseData);
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('리뷰 리스트 조회 실패');
    }

  }
}