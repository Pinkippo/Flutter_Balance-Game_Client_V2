import 'package:flutter/material.dart';
import 'package:yangjataekil/controller/notice_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';
import 'package:yangjataekil/widget/mypage/notice_tab_widget.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            '공지사항',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.primaryColor,
            tabs: <Widget>[
              Tab(
                child: Text(
                  '전체',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  '일반',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  '이벤트',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            NoticeAllTab(noticeType: 'ALL'),
            NoticeAllTab(noticeType: 'GENERAL'),
            NoticeAllTab(noticeType: 'EVENT'),
          ],
        ),
      ),
    );
  }
}
