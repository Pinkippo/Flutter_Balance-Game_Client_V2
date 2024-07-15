import 'package:flutter/cupertino.dart';
import 'package:yangjataekil/theme/app_color.dart';

class NotificationBtn extends StatefulWidget {
  final String title;
  final bool isChecked;

  const NotificationBtn({
    super.key,
    required this.title,
    required this.isChecked,
  });

  @override
  State<NotificationBtn> createState() => _NotificationBtnState();
}

class _NotificationBtnState extends State<NotificationBtn> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
        CupertinoSwitch(
          value: _isChecked,
          activeColor: AppColors.primaryColor,
          onChanged: (bool? value) {
            setState(() {
              /// TODO: 상태 변경 api 요청
              _isChecked = value ?? false;
            });
          },
        ),
      ],
    );
  }
}
