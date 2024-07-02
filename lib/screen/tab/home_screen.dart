import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xffFFE2E3),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Container(
                    color: const Color(0xffFFE2E3),
                    height: 220,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              // color: Colors.white,
                              width: 200,
                              height: 55,
                              margin: const EdgeInsets.only(left: 20, top: 20),
                              child: const Text(
                                '첫 의견 남기고 5000원\n받아가세요 어쩌고~!',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.white,
                              width: 200,
                              height: 55,
                              margin: const EdgeInsets.only(left: 20, top: 5),
                              child: Text(
                                '질문만 만들어도 어쩌고 저쩌고\n포인트가 쑥쑥!',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          // color: Colors.white,
                          width: 140,
                          height: 140,
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          child: Image.asset('assets/images/home_img.png'),
                        ),
                      ],
                    ),
                  ),

                  /// 하단 부분
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  Text(
                                    '테마별로 알아봐요',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.13),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('theme'),
                                          Text('밸런스 게임'),
                                          Icon(Icons.shopping_bag_outlined),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        '오늘의 추천 밸런스 게임',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 180,
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.13),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('병맛 밸런스 게임?\n궁금하면 들어와',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(height: 15),
                                        Text(
                                          '"나는 이상한(?)게임이 하고 싶다"\n"나는 말이 안 되는 질문이 좋다"',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 68,
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30, top: 20),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xffFFD3D4),
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: const Text('게임하러 가기'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(height: 200, color: Colors.black,),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 180, // Adjust this value as needed
              left: 20, // Adjust this value as needed
              right: 20, // Adjust this value as needed
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '중간에 띄울 내용',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
