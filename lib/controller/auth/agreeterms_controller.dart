import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AgreeTermsController extends GetxController {
  final isAllAgree = false.obs;

  final isPrivacyAgree = false.obs;

  final isMarketingAgree = false.obs;

  void allAgree() {
    isAllAgree.value = !isAllAgree.value;
    isPrivacyAgree.value = isAllAgree.value;
    isMarketingAgree.value = isAllAgree.value;
  }

  void privacyAgree() {
    isPrivacyAgree.value = !isPrivacyAgree.value;
    if (isPrivacyAgree.value && isMarketingAgree.value) {
      isAllAgree.value = true;
    } else {
      isAllAgree.value = false;
    }
  }

  void marketingAgree() {
    isMarketingAgree.value = !isMarketingAgree.value;
    if (isPrivacyAgree.value && isMarketingAgree.value) {
      isAllAgree.value = true;
    } else {
      isAllAgree.value = false;
    }
  }
}
