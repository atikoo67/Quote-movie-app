import 'package:flutter/material.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';

class PasswordTextField extends StatefulWidget {
  // final String hintText;
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const PasswordTextField({
    super.key,
    // required this.hintText,
    required this.label,
    required this.validator,

    required this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordhidden = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.screenHeight(context) * 0.025,
        vertical: 8,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,

        controller: widget.controller,
        obscureText: passwordhidden,
        obscuringCharacter: '*',
        style: theme.textTheme.titleSmall,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),

          labelStyle: theme.textTheme.titleSmall,
          // hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),

          labelText: widget.label,

          isDense: true,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                passwordhidden = !passwordhidden;
              });
            },
            child: passwordhidden
                ? Icon(Icons.visibility_off, color: theme.iconTheme.color)
                : Icon(Icons.visibility, color: theme.iconTheme.color),
          ),

          filled: true,
        ),
      ),
    );
  }
}
