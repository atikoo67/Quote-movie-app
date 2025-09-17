import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote/features/authentication/presentation/page/auth_page.dart';
import 'package:quote/features/movie/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';

class SignInChecker extends StatelessWidget {
  const SignInChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.email);
            return MainPage();
          } else {
            return QuoteAuth();
          }
        },
      ),
    );
  }
}
