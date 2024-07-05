import 'package:flutter/material.dart';

class ChkEmailBtn extends StatelessWidget {
  const ChkEmailBtn({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final String title;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffE5E5E5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
