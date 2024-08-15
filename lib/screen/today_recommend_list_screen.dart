import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yangjataekil/controller/list_controller.dart';

class TodayRecommendListScreen extends GetView<ListController> {
  const TodayRecommendListScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 추천'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '오늘의 추천',
            ),
            ElevatedButton(onPressed: (){
              controller.getRecommendList();
            }, child: const Text('오늘의 추천')),
          ],
        ),
      ),
    );
  }
}
