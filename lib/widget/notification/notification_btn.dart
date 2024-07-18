import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/notification_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class NotificationBtn extends StatelessWidget {
  final String title;
  final bool isChecked;
  final NotificationController controller;

  const NotificationBtn({
    super.key,
    required this.title,
    required this.isChecked,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isChecked;
    Function(bool) onChanged;

    switch (title) {
      case '마케팅 정보 수신 동의':
        isChecked = controller.isCheckedMarketing;
        onChanged = controller.updateMarketing;
        break;
      case '문자 알림':
        isChecked = controller.isCheckedMessage;
        onChanged = controller.updateMessage;
        break;
      case '포인트 적립 알림':
        isChecked = controller.isCheckedPoint;
        onChanged = controller.updatePoint;
        break;
      default:
        isChecked = false.obs;
        onChanged = (_) {};
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        Obx(
          () => CupertinoSwitch(
            value: isChecked.value,
            activeColor: AppColors.primaryColor,
            onChanged: (bool value) {
              /// TODO: 상태 변경 api 요청
              onChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
