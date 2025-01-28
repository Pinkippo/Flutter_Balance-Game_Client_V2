import 'package:flutter/material.dart';
import 'package:yangjataekil/controller/auth/register_controller.dart';
import 'package:yangjataekil/theme/app_color.dart';

class BirthInputField extends StatelessWidget {
  const BirthInputField({
    super.key,
    required this.registerController,
  });

  final RegisterController registerController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primaryColor, // Header background color
                ),
                dialogBackgroundColor: Colors.white, // Background color
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          registerController.updateBirth(pickedDate);
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: registerController.birthController,
          decoration: InputDecoration(
            hintText: 'ex) 20000101',
            suffixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
