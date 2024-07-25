import 'package:flutter/material.dart';
import 'package:yangjataekil/theme/app_color.dart';

class KeywordWidget extends StatelessWidget {
  final String keyword;

  const KeywordWidget({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
        child: Text(
          keyword,
          style: const TextStyle(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
