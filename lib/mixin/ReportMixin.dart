import 'package:get/get.dart';
import 'package:yangjataekil/controller/review/review_controller.dart';

mixin ReportMixin on GetxController {
  RxList<REPORTCATEGORY> categories = <REPORTCATEGORY>[].obs;
  Rx<REPORTCATEGORY?> selectedCategory = Rx<REPORTCATEGORY?>(null);
  Rx<String> reportReason = ''.obs;

  void initializeCategories(List<REPORTCATEGORY> initialCategories) {
    categories.assignAll(initialCategories);
  }

  void toggleCategory(REPORTCATEGORY category) {
    selectedCategory.value = category;
  }

  void updateContent(String value) {
    reportReason.value = value;
  }

  Future<bool> reportGame(int boardId, String reason);
}


