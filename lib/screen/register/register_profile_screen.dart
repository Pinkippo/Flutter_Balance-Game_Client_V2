import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/register_controller.dart';
import 'package:yangjataekil/utils/text_util.dart';
import 'package:yangjataekil/widget/register/nickname_input_field.dart';
import 'package:yangjataekil/widget/register/basic_btn.dart';
import 'package:yangjataekil/widget/register/register_profile.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

class RegisterProfileScreen extends GetView<RegisterController> {
  const RegisterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
        elevation: 0,
        title: const Text(
          '회원가입',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          '사진과 이름을 등록해주세요',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RegisterProfile(),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '닉네임',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: NicknameInputField(
                        hintText: '닉네임',
                        obscureText: false,
                        textController: controller.nicknameController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BasicBtn(
              onPressed: () async {
                bool checkProfanity = await TextUtil().textFiltering(controller.nickname.value);
                if(checkProfanity) {
                  CustomSnackBar.showErrorSnackBar(title: '닉네임 생성 제한', message: '비속어가 포함되어 있습니다.');
                  return;
                }
                controller.register();
              },
              buttonText: '회원가입',
            ),
          ],
        ),
      ),
    );
  }
}
