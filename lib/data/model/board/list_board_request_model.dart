import 'package:yangjataekil/controller/list_controller.dart';

class ListBoardRequestModel {
  final int size;
  final int page;
  final SORTCONDITION? sortCondition;
  final int themeId;

  ListBoardRequestModel({
    required this.size, required this.page, required this.sortCondition, required this.themeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'page': page,
      'sortCondition': sortCondition,
      'themeId' : themeId,
    };
  }
}