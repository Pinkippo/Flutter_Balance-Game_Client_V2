import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/agreeterms_controller.dart';
import 'package:yangjataekil/screen/auth/agreeterms_item_screen.dart';
import 'package:yangjataekil/theme/app_color.dart';

class AgreeTermsScreen extends GetView<AgreeTermsController> {
  const AgreeTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                '필수항목 및 선택항목 이용약관\n동의가 필요합니다.',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
              ),
            ),
            const SizedBox(height: 40),
            Obx(
              () => ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                horizontalTitleGap: 0,
                leading: Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    value: controller.isAllAgree.value,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onChanged: (value) {
                      controller.allAgree();
                    },
                    activeColor: const Color(0xFFFF3A3A),
                  ),
                ),
                title: const Text(
                  '전체동의',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              thickness: 1,
            ),
            Obx(
              () => ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                horizontalTitleGap: 0,
                leading: Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    value: controller.isPrivacyAgree.value,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onChanged: (value) {
                      controller.privacyAgree();
                    },
                    activeColor: const Color(0xFFFF3A3A),
                  ),
                ),
                title: Text(
                  '개인정보 수집 및 이용동의 (필수)',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.4),
                  size: 15,
                ),
                onTap: () {
                  Get.to(
                    () => const AgreeTermsItemScreen(
                      url:
                          'https://www.notion.so/6427195b9c764fedbf5533462be5aabd?pvs=4',
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                horizontalTitleGap: 0,
                leading: Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    value: controller.isMarketingAgree.value,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onChanged: (value) {
                      controller.marketingAgree();
                    },
                    activeColor: const Color(0xFFFF3A3A),
                  ),
                ),
                title: Text(
                  '서비스 이용약관 동의 (필수)',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.4),
                  size: 15,
                ),
                onTap: () {
                  Get.to(
                    () => const AgreeTermsItemScreen(
                        url:
                            'https://www.notion.so/b93ac0029cec4144ad3a09774e8f2929?pvs=4'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          controller.isPrivacyAgree.value ? Get.toNamed('/register') : null;
        },
        child: Obx(
          () => Container(
            width: double.infinity,
            height: 80,
            color: controller.isPrivacyAgree.value
                ? AppColors.primaryColor
                : Colors.grey,
            child: const Center(
              child: Text(
                '다음',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
