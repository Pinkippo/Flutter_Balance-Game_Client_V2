import 'package:flutter/material.dart';

Widget bubbleWidget({
  required String comment,
  required IconData icon,
  required Color iconColor,
  Color color = Colors.grey,
}) =>
    ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: const EdgeInsets.only(
          top: 2,
          left: 10,
          right: 10,
          bottom: 17,
        ),
        color: color,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 5),
            Text(
              comment,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(15, 0);
    path.lineTo(size.width - 15, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 15);
    path.lineTo(size.width, size.height - 30);
    path.quadraticBezierTo(size.width, size.height - 15, size.width - 15, size.height - 15);
    path.lineTo(40, size.height - 15); // 꼬리 시작점 더 안쪽으로 이동
    path.lineTo(30, size.height - 5);  // 꼬리 끝점 더 얇게 이동
    path.quadraticBezierTo(30, size.height - 5, 30, size.height - 7);
    path.lineTo(30, size.height - 15);
    path.lineTo(15, size.height - 15);
    path.quadraticBezierTo(0, size.height - 15, 0, size.height - 30);
    path.lineTo(0, 15);
    path.quadraticBezierTo(0, 0, 15, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
