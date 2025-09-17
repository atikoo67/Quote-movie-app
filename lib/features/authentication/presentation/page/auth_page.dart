import 'package:flutter/material.dart';
import 'package:quote/features/authentication/presentation/page/createaccount.dart';
import 'package:quote/features/authentication/presentation/page/loginpage.dart';

class QuoteAuth extends StatefulWidget {
  const QuoteAuth({super.key});

  @override
  State<QuoteAuth> createState() => _QuoteAuthPageState();
}

class _QuoteAuthPageState extends State<QuoteAuth> {
  bool isLoginpage = true;
  void toggleScree() {
    setState(() {
      isLoginpage = !isLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginpage) {
      return LoginPage(showSignupPage: toggleScree);
    } else {
      return CreateAccount(showLoginPage: toggleScree);
    }
  }
}
