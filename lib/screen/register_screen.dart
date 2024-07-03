import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/register_controller.dart';
import 'package:yangjataekil/widget/register/basic_input_field.dart';
import 'package:yangjataekil/widget/register/chk_email_btn.dart';
import 'package:yangjataekil/widget/register/email_input_field.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
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
                  child: Text('이메일'),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: EmailInputField(
                            hintText: '이메일',
                            obscureText: false,
                            controller: controller,
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
                      flex: 2,
                      child: ChkEmailBtn(
                          onPressed: () => {
                                /// TODO: 이메일 중복 검사 연결
                              }),
                    )
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
                        obscureText: false,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: BasicInputField(
                        hintText: '비밀번호 확인',
                        obscureText: false,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
