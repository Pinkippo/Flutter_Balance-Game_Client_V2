import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/login/auto_login.dart';
import 'package:yangjataekil/widget/login/login_input_field.dart';
import 'package:yangjataekil/widget/login/login_btn.dart';
import 'package:yangjataekil/widget/login/signup_btn.dart';

import '../controller/login_controller.dart';

/// 로그인 화면
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Get.previousRoute == '' ? false : true,
      child: Scaffold(
        /// 상단
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: const Border(
            bottom: BorderSide(color: Colors.grey, width: 0.3),
          ),
          elevation: 0,
          title: const Text('로그인',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.previousRoute == '' ? null : Get.back();
            },
          ),
        ),

        /// 중단
        body: Container(
          height: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(), // 오버 스크롤 방지
            child: Column(
              children: <Widget>[
                const Image(
                    image: AssetImage('assets/images/before_logo.png'),
                    width: 180,
                    height: 180),
                Form(
                  // key: controller.formKey,
                  child: Column(
                    children: [
                      LoginTextFormField(
                          hintText: '아이디',
                          obscureText: false,
                          loginController: controller),

                      const SizedBox(height: 17),

                      LoginTextFormField(
                          hintText: '비밀번호',
                          obscureText: true,
                          loginController: controller),

                      const SizedBox(height: 10),

                      const AutoLogin(),

                      const SizedBox(height: 20),

                      LoginBtn(onPressed: () {
                        /// TODO : 로그인 기능 연결
                        Get.showOverlay(
                            asyncFunction: () async {
                              return await controller.login(
                                  controller.loginUserId.value,
                                  controller.loginUserPw.value);
                            },
                            loadingWidget: const Center(
                              child: SpinKitThreeBounce(
                                color: AppColors.primaryColor,
                                size: 30.0,
                              ),
                            )).then((value) {
                          if (value == true) {
                            Get.offAllNamed('/main');
                          }
                        });
                      }),

                      const SizedBox(height: 15),

                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                /// TODO : 아이디 찾기 연결
                                // Get.toNamed('/find_id');
                              },
                              child: const Text(
                                '아이디 찾기 ',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            const VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                /// TODO : 비밀번호 찾기 연결
                                // Get.toNamed('/find_pw');
                              },
                              child: const Text(
                                ' 비밀번호 찾기',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 23),

                      const Divider(
                        color: Colors.grey,
                        thickness: 0.4,
                      ),

                      const SizedBox(height: 23),

                      const Row(
                        children: [
                          Text(
                            '아직 회원이 아니신가요?',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      SignUpBtn(
                        onPressed: () => {
                          Get.toNamed('/agree_terms'),
                          // Get.toNamed('/register'),
                        },
                      ),

                      /// TODO: 소셜 로그인 기능 추가
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
