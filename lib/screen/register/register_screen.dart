import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/auth/register_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/utils/text_util.dart';
import 'package:yangjataekil/widget/register/basic_input_field.dart';
import 'package:yangjataekil/widget/register/check_email_btn.dart';
import 'package:yangjataekil/widget/register/email_input_field.dart';
import 'package:yangjataekil/widget/register/basic_btn.dart';
import 'package:yangjataekil/widget/snackbar_widget.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.2),
        ),
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
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          // 오버 스크롤 방지
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('이름'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BasicInputField(
                        hintText: '이름',
                        obscureText: false,
                        controller: controller,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('아이디'),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: EmailInputField(
                        hintText: '아이디',
                        obscureText: false,
                        textController: controller.accountNameController,
                        icon: const Icon(
                          size: 20,
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Obx(
                        () => ChkEmailBtn(
                          title: '중복확인',
                          color: controller.accountName.isEmpty
                              ? const Color(0xffE5E5E5)
                              : AppColors.primaryColor,
                          fontColor: controller.accountName.isEmpty
                              ? Colors.grey
                              : Colors.white,
                          onPressed: () =>
                              {controller.checkDuplicateAccountName()},
                          isEnabled:
                              controller.accountName.isEmpty ? false : true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('비밀번호'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BasicInputField(
                        hintText: '비밀번호',
                        obscureText: true,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: BasicInputField(
                        hintText: '비밀번호 확인',
                        obscureText: true,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '영문 대문자와 소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 6~20자로 입력해주세요.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text('이메일'),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: BasicInputField(
                        hintText: '이메일',
                        obscureText: false,
                        controller: controller,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Obx(
                        () => ChkEmailBtn(
                          title: '인증요청',
                          color: controller.email.isEmpty
                              ? const Color(0xffE5E5E5)
                              : AppColors.primaryColor,
                          fontColor: controller.email.value.isEmpty
                              ? Colors.grey
                              : Colors.white,
                          onPressed: () =>
                              controller.requestEmailVerification(),
                          // 이메일 인증 완료 시 비활성화
                          isEnabled: controller.email.isEmpty ? false : true,
                          // controller.email.isEmpty ? false : true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Obx(
                          () => TextField(
                            // 이메일 인증 완료 시 비활성화
                            enabled: !controller.isEmailVerified.value,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration(
                              hintText: '인증번호를 입력해주세요.',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffFF9297),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              controller.updateEmailAuthCode(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Obx(
                        () => ChkEmailBtn(
                          title: '인증확인',
                          color: controller.isEmailSent.value
                              ? AppColors.primaryColor
                              : const Color(0xffE5E5E5),
                          fontColor: controller.isEmailSent.value
                              ? Colors.white
                              : Colors.grey,
                          onPressed: () => controller.verifyEmail(),
                          // 이메일 인증 완료 시 비활성화
                          isEnabled: controller.isEmailVerified.value
                              ? false
                              : (controller.isEmailSent.value ? true : false),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: BasicBtn(
          onPressed: () async {
            bool checkProfanity = await TextUtil().textFiltering(controller.realName.value);
            if(checkProfanity) {
              CustomSnackBar.showErrorSnackBar(title: '이름 생성 제한', message: '비속어가 포함되어 있습니다!');
              return;
            }
            controller.nextStep();
          },
          buttonText: '다음',
        ),
      ),
    );
  }
}
