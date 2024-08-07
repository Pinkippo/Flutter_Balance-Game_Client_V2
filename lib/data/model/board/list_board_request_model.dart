import 'package:yangjataekil/controller/list_controller.dart';

class ListBoardRequestModel {
  final bool searching;
  final String query;
  final int size;
  final int page;
  final SORTCONDITION? sortCondition;
  final int themeId;

  ListBoardRequestModel({
    required this.searching,
    required this.query,
    required this.size,
    required this.page,
    required this.sortCondition,
    required this.themeId,
  });

  Map<String, dynamic> toJson() {
    if(searching) {
      return {
        'query': query,
        'page': page,
        'size': size,
        'sortCondition': sortCondition?.name ?? '',
        'themeId': themeId,
      };
    } else {
      return {
        'page': page,
        'size': size,
        'sortCondition': sortCondition?.name ?? '',
        'themeId': themeId,
      };
    }
  }
}
