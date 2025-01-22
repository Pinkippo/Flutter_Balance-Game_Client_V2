import 'package:flutter/services.dart';

class TextUtil {

/// 비속어 필터링 메서드
  Future<bool> textFiltering(String text) async {
    String path = 'assets/word_list.txt';
    try {
      String content = await rootBundle.loadString(path);
      List<String> wordList = content.split('\n');

      for (String word in wordList) {
        if (text.toLowerCase().contains(word.toLowerCase())) {
          return true; // 비속어가 포함된 경우
        }
      }
      return false; // 비속어가 없는 경우
    } catch (e) {
      print('비속어 필터링 에러 발생: $e');
      return false;
    }
  }

}
