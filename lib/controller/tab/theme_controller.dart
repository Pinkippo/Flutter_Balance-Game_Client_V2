import 'package:get/get.dart';
import 'package:yangjataekil/data/model/theme/list_theme_response.dart';
import 'package:yangjataekil/data/provider/theme_repository.dart';
import 'package:yangjataekil/data/model/theme/theme.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  final RxList<Theme> themes = <Theme>[].obs;
  final RxInt selectedThemeId = 0.obs;

  @override
  void onInit() {
    _getThemes();
    super.onInit();
  }

  void changeIndex(int themeId) {
    selectedThemeId.value = themeId; // selectedTheme를 새로운 값으로 설정
    print('선택된 테마 ID: $selectedThemeId');
  }

  Future<void> _getThemes() async {
    try {
      ListThemeResponse response = await ThemeRepository().getList();
      themes.addAll(response.themes);
    } catch (e) {
      print('테마 조회 실패: $e');
      CustomSnackBar.showErrorSnackBar(message: '테마 조회 실패');
    }
  }

  // 현재 테마 이름 가져오기
  String getThemeName() {
    return themes
        .firstWhere((element) => element.themeId == selectedThemeId.value)
        .theme;
  }
}
