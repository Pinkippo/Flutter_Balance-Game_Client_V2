import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/user_modify_controller.dart';
import 'package:yangjataekil/widget/mypage/modify_nickname_input_field.dart';
import 'package:yangjataekil/widget/mypage/modify_profile_widget.dart';
import 'package:yangjataekil/widget/register/basic_btn.dart';

class UserModifyScreen extends GetView<UserModifyController> {
  const UserModifyScreen({super.key});

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
          '정보수정',
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ModifyProfile(),
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
                        child: ModifyNicknameInputField(
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
                  controller.modify();
                },
                buttonText: '확인',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
