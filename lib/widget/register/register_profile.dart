import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yangjataekil/controller/register_controller.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';
import 'package:yangjataekil/theme/app_color.dart';

class RegisterProfile extends GetView<RegisterController> {
  const RegisterProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Obx(
          () => CircleAvatar(
            radius: 80,
            backgroundColor: AppColors.profileBackgroundColor,
            backgroundImage: controller.profile.value != null
                ? FileImage(File(controller.profile.value!.path))
                : null,
          ),
        ),
        Positioned(
          child: InkWell(
            onTap: () {
              Get.bottomSheet(
                bottomSheet(),
                backgroundColor: Colors.white,
              );
            },
            child: const Icon(
              Icons.add,
              color: AppColors.profileIconColor,
              size: 100,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text('사진을 등록해주세요!'),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    controller.updateProfile(image);
                    controller.profileUrl.value = await controller
                        .authRepository
                        .uploadProfileImage(image);
                    print('profileUrl >> ${controller.profileUrl.value}');
                    Get.back();
                  }
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () async {
                  /// TODO: 회원가입 중단 시 이미지 삭제??
                  final picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    controller.updateProfile(image);
                    controller.profileUrl.value = await controller
                        .authRepository
                        .uploadProfileImage(image);
                    Get.back();
                  }
                },
                icon: const Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 50,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
