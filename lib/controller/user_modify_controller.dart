import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yangjataekil/controller/auth_controller.dart';
import 'package:yangjataekil/data/model/user_modify_request_model.dart';
import 'package:yangjataekil/data/provider/auth_repository.dart';

class UserModifyController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

  /// 닉네임
  final Rx<String> nickname = AuthController.to.nickname;

  /// 프로필 사진
  final Rx<XFile?> profile = Rx<XFile?>(null);

  /// 프로필 사진 URL
  final Rx<String?> profileUrl = AuthController.to.profileUrl;

  final nicknameController = TextEditingController();

  @override
  void onInit() {
    nicknameController.text = nickname.value;
    super.onInit();
  }

  /// 닉네임 입력
  void updateNickname(String nickname) {
    this.nickname.value = nickname;
    print('nickname >> $nickname');
  }

  /// 프로필 사진 업데이트
  void updateProfile(XFile image) {
    profile.value = image;
    print('profile 사진 랜더링 완료');
  }

  void modify() async {
    final bool response = await authRepository.modify(
        UserModifyRequestModel(
          nickname: nickname.value,
          profileUrl: profileUrl.value,
        ),
        AuthController.to.accessToken.value);
    print(response);
    Get.offNamed('/main');
  }
}
