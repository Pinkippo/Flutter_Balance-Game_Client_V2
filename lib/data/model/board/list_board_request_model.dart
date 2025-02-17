import 'package:yangjataekil/controller/list/theme_list_controller.dart';

enum SORTCONDITION { LIKE, DATE }

class ListBoardRequestModel {
  final bool searching;
  final String? query;
  final int size;
  final int page;
  final SORTCONDITION? sortCondition;
  final int? themeId;

  ListBoardRequestModel({
    required this.searching,
    this.query,
    required this.size,
    required this.page,
    required this.sortCondition,
    this.themeId,
  });
}
