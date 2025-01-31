import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCustomDialog {
  showConfirmDialog({
    required String title,
    required String content,
    required Future<void> Function() onConfirm,
    required String confirmText,
    bool? isBarrierDismissible,
    void Function()? onCancel,
  }) {
    Get.dialog(
      barrierDismissible: isBarrierDismissible ?? true,
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: Text(content),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(105, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await onConfirm();
                },
                child: Text(
                  confirmText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(105, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  overlayColor: Colors.white,
                ),
                onPressed: () {
                  // onCancel 기본값 Get.back() 처리
                  (onCancel ?? Get.back)();
                },
                child: const Text(
                  '취소',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
