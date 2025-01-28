import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:yangjataekil/screen/auth/agreeterms_item_screen.dart';

class UserAgreenment extends StatelessWidget{
  const UserAgreenment({super.key});

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar : AppBar(
        backgroundColor : Colors.white,
        title: const Text(
          '이용약관',
          style: TextStyle(
            fontSize: 17,
            fontWeight : FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: const Text('개인정보 수집 및 이용동의'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Get.to(
                          () => const AgreeTermsItemScreen(
                        url:
                        'https://www.notion.so/6427195b9c764fedbf5533462be5aabd?pvs=4',
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('서비스 이용약관'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Get.to(
                          () => const AgreeTermsItemScreen(
                          url:
                          'https://www.notion.so/b93ac0029cec4144ad3a09774e8f2929?pvs=4'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
