import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;

  final Function()? onPressed;
  const MyTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,

      child: Text(text, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}
