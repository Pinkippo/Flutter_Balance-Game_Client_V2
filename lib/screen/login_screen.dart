import 'package:flutter/material.dart';
import 'package:yangjataekil/widget/login/auto_login.dart';
import 'package:yangjataekil/widget/login/input_field.dart';
import 'package:yangjataekil/widget/login/login_btn.dart';
import 'package:yangjataekil/widget/login/signup_btn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        title: const Text('로그인', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Image(
                  image: AssetImage('assets/images/before_logo.png'),
                  width: 180,
                  height: 180),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LoginTextFormField(
                        hintText: '아이디',
                        obscureText: false,
                        controller: _idController),
                    const SizedBox(height: 17),
                    LoginTextFormField(
                        hintText: '비밀번호',
                        obscureText: true,
                        controller: _passwordController),
                    const SizedBox(height: 10),
                    const AutoLogin(),
                    const SizedBox(height: 20),
                    LoginBtn(onPressed: () => print('로그인 버튼 클릭')),
                    const SizedBox(height: 15),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('아이디 찾기 버튼 클릭');
                              // Navigator.pushNamed(context, '/find_id');
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
                              print('비밀번호 찾기 버튼 클릭');
                              // Navigator.pushNamed(context, '/find_pw');
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
                      onPressed: () => print('회원가입 버튼 클릭'),
                      // Navigator.pushNamed(context, '/register')),
                    ),

                    /// TODO: 소셜 로그인 기능 추가
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}