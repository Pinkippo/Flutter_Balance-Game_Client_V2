import 'package:yangjataekil/data/model/theme/theme.dart';

class ListThemeResponse {
  final List<Theme> themes;

  ListThemeResponse({
    required this.themes,
  });

  factory ListThemeResponse.fromJson(Map<String, dynamic> json) {
    var themesJson = json['themes'] as List;
    List<Theme> themeList = themesJson.map((i) => Theme.fromJson(i)).toList();

    return ListThemeResponse(
      themes: themeList,
    );
  }
}
