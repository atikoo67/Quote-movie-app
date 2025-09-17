import 'package:flutter/material.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  TextInputType? keyboardType;
  MyTextField({
    super.key,

    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: TextFormField(
        keyboardType: keyboardType,

        controller: controller,
        style: AppTextStyle.textTheme.titleSmall,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),

          labelText: label,
          labelStyle: theme.textTheme.titleSmall,
          // hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),

          filled: true,
        ),
      ),
    );
  }
}
