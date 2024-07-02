import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/login_controller.dart';


class AutoLogin extends GetView<LoginController> {
  const AutoLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Checkbox(
            value: controller.autoLogin.value,
            onChanged: (value) {
              controller.toggleAutoLogin();
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            side: const BorderSide(color: Color(0xffD1D1D1)),
            activeColor: const Color(0xffFF9297),
          ),
          const SizedBox(width: 5),
          const Text('자동 로그인'),
        ],
      ),
    );
  }
}
