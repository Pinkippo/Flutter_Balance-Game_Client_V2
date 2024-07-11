import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/register_controller.dart';
import 'package:yangjataekil/widget/register/nickname_input_field.dart';
import 'package:yangjataekil/widget/register/basic_btn.dart';
import 'package:yangjataekil/widget/register/register_profile.dart';

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
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RegisterProfile(
                            controller: controller,
                          )
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
                onPressed: () {
                  /// TODO: 회원가입 API 연결
                },
                buttonText: '회원가입',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
