import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  final Widget title;
  Widget? subtitle;
  MyCheckBox({super.key, required this.title, this.subtitle});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: 10,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = !isActive;
            });
          },
          child: Icon(
            isActive ? Icons.check_box : Icons.check_box_outline_blank,
            color: isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [widget.title, widget.subtitle!],
        ),
      ],
    );
  }
}
