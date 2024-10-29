import 'package:yangjataekil/data/model/game/game_detail_board_review_preview.dart';
import 'package:yangjataekil/data/model/game/game_detail_writer.dart';

/// 게임 상세 응답 모델
class GameDetailResponseModel {
  final int boardId;
  final Writer writer;
  final String title;
  final String introduce;
  final int likeCount;
  final int dislikeCount;
  final int viewCount;
  final int boardReviewCount;
  final List<BoardReviewPreview> boardReviewsPreview;
  final DateTime createdAt;
  final DateTime updatedAt;

  GameDetailResponseModel({
    required this.boardId,
    required this.writer,
    required this.title,
    required this.introduce,
    required this.likeCount,
    required this.dislikeCount,
    required this.viewCount,
    required this.boardReviewCount,
    required this.boardReviewsPreview,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GameDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return GameDetailResponseModel(
      boardId: json['board']['boardId'],
      writer: Writer.fromJson(json['board']['writer']),
      title: json['board']['title'],
      introduce: json['board']['introduce'],
      likeCount: json['board']['likeCount'],
      dislikeCount: json['board']['dislikeCount'],
      viewCount: json['board']['viewCount'],
      boardReviewCount: json['board']['boardReviewCount'],
      boardReviewsPreview: (json['board']['boardReviewsPreview'] as List)
          .map((item) => BoardReviewPreview.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['board']['createdAt']),
      updatedAt: DateTime.parse(json['board']['updatedAt']),
    );
  }
}
