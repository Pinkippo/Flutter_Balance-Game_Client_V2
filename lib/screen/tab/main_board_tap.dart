import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/theme/app_color.dart';

class BoardTap extends StatelessWidget {
  const BoardTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          elevation: 0,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
            Get.toNamed('/upload_game');
        },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
