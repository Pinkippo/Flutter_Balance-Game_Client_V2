import 'package:get/get.dart';

/// 하단 네비게이터 컨트롤러
class BottomNavigatorController extends GetxController {
  /// .to로 생성된 인스턴스에 접근하기 위한 static 변수
  static BottomNavigatorController get to => Get.find();

  /// 선택된 탭 인덱스 정보
  final RxInt selectedIndex = 1.obs;

  /// 선택된 탭 인덱스 변경 - 메서드
  void changeIndex(int index) {
    selectedIndex(index);
  }
}