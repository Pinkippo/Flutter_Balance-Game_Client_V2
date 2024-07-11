import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yangjataekil/controller/register_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class RegisterProfile extends StatefulWidget {
  final RegisterController controller;

  const RegisterProfile({super.key, required this.controller});

  @override
  State<RegisterProfile> createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  final picker = ImagePicker();
  XFile? image; // 카메라 이미지 저장 변수

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: AppColors.profileBackgroundColor,
          backgroundImage: widget.controller.profile.value != null
              ? FileImage(File(widget.controller.profile.value!.path))
              : null,
        ),
        Positioned(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => bottomSheet()));
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
                  image = await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    widget.controller.updateProfile(image!);
                    setState(() {
                      navigator?.pop(context);
                    });
                  }
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    widget.controller.updateProfile(image!);

                    setState(() {
                      navigator?.pop(context);
                    });
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
