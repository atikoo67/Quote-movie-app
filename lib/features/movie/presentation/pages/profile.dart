import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final profile = args['profile'] as Map<String, dynamic>;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Profile', style: theme.textTheme.bodyMedium)),
      body: Column(
        children: [
          Text("${profile['email']}"),
          Text("${profile["username"]}"),
          Text("${profile["phonenumber"]}"),
        ],
      ),
    );
  }
}
