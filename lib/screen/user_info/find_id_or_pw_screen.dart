import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/find_id_pw_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class FindIdOrPw extends GetView<FindIdPwController> {
  const FindIdOrPw({super.key, required this.findType});

  final String findType; // 아이디 찾기인지 비밀번호 찾기인지 구분

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: findType == 'id'
                ? const Text(
                    '아이디 찾기',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    '비밀번호 찾기',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          body: GestureDetector(
            onTap: () {
              // 키보드 내리기
              Get.focusScope?.unfocus();
            },
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// 가입된 이메일 입력 부분
                  findType == 'id'
                      ? TextFormField(
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(250, 249, 249, 0),
                            hintText: '가입된 이메일',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          onChanged: (value) {
                            controller.changeInputEmail(value);
                          },
                        )
                      : TextFormField(
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(250, 249, 249, 0),
                            hintText: '아이디',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          onChanged: (value) {
                            controller.changeInputId(value);
                          },
                        ),

                  const SizedBox(height: 8),

                  /// 아이디, 비밀번호 찾기 버튼
                  ElevatedButton(
                    onPressed: () {
                      findType == 'id'
                          ? controller.findId()
                          : controller.findPw();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 45),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: findType == 'id'
                        ? const Text(
                            '아이디 찾기',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            '비밀번호 찾기',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 25),

                  /// 안내문구
                  const Text(
                    '※ 가입된 아이디가 있을 경우, 입력하신 이메일로 아이디를 안내해 드립니다.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 9),
                  const Text(
                    '※ 만약 이메일이 오지 않는다면, 스팸 편지함으로 이동하지 않았는지 확인해주세요.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 9),
                  const Text(
                    '※ 이메일이 즉시 도착하지 않을 수 있으니, 최대 30분 정도 기다리신 후 다시 시도해주세요.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// 로딩 중 스피너 표시
        Obx(
          () => Offstage(
            offstage: !controller.isLoading.value,
            child: const Stack(
              children: [
                ModalBarrier(
                  color: Colors.black26,
                  dismissible: false,
                ),
                Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.primaryColor,
                    size: 30.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
