import 'package:flutter/material.dart';
import 'package:yangjataekil/theme/app_thene.dart';

class RegisterBtn extends StatelessWidget {
  const RegisterBtn({Key? key, required this.onPressed}) : super(key: key);
  
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFF9297),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: const Text('회원가입', style: TextStyle(fontSize: 16, color: Colors.white),),
      ),
    );
  }
}
