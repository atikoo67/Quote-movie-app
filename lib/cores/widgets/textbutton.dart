import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Function()? onPressed;
  const MyTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,

      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Theme.of(context).textTheme.displaySmall!.color,
        ),
      ),
    );
  }
}
