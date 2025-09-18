import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quote/features/authentication/presentation/config_login/signinchecker.dart';
import 'package:quote/cores/utils/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:quote/features/movie/presentation/pages/downloads.dart';
import 'package:quote/features/movie/presentation/pages/favorites_page.dart';
import 'package:quote/features/movie/presentation/pages/main_page.dart';
import 'package:quote/features/movie/presentation/pages/profile.dart';

final GlobalKey backgroundKey = GlobalKey();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.storage.request();
  await Permission.manageExternalStorage.request();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkMode,

      debugShowCheckedModeBanner: false,
      home: SignInChecker(),
      routes: {
        "/home": (context) => MainPage(),
        "/signout": (context) => SignInChecker(),
        "/downloads": (context) => Downloads(),
        "/profile": (context) => MyProfile(),
        "/favorites": (context) => Favorites(),
      },
    );
  }
}
