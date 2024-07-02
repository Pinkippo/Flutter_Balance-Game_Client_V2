import 'package:flutter/material.dart';

class GameByTheme extends StatelessWidget {
  const GameByTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('theme'),
          Text('밸런스 게임'),
          Icon(Icons.shopping_bag_outlined),
        ],
      ),
    );
  }
}
