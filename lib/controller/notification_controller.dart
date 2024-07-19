import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxBool isCheckedMarketing = false.obs;
  final RxBool isCheckedMessage = false.obs;
  final RxBool isCheckedPoint = false.obs;

  void updateMarketing(bool checked) {
    isCheckedMarketing.value = checked;
    print('isCheckedMarketing >> $isCheckedMarketing');
  }

  void updateMessage(bool checked) {
    isCheckedMessage.value = checked;
    print('isCheckedMessage >> $isCheckedMessage');
  }

  void updatePoint(bool checked) {
    isCheckedPoint.value = checked;
    print('isCheckedPoint >> $isCheckedPoint');
  }
}
