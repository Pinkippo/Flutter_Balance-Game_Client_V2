import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/theme/app_color.dart';

class EmptyGameDetailScreen extends StatelessWidget {
  const EmptyGameDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 앱바
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.secondaryColor,
          surfaceTintColor: AppColors.secondaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            '추천 게임',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Text(
          '추천 게임 정보가 없어요!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
