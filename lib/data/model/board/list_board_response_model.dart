import 'package:yangjataekil/data/model/board/board.dart';

class ListBoardResponseModel {
  final List<Board> boards;
  final int totalPage;

  ListBoardResponseModel({
    required this.boards,
    required this.totalPage,
  });

  factory ListBoardResponseModel.fromJson(Map<String, dynamic> json) {
    var boardsJson = json['boards']['boards'] as List;
    List<Board> boardsList = boardsJson.map((i) => Board.fromJson(i)).toList();

    return ListBoardResponseModel(
      boards: boardsList,
      totalPage: json['boards']['totalPage'],
    );
  }
}
