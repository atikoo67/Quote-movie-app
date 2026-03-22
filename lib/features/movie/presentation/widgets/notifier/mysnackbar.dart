import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MySnackbar {
  static Future showSnack(
    BuildContext context,
    String message,
    Color? backgroundcolor,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundcolor ?? Colors.green[800],
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
