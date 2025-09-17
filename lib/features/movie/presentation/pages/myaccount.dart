import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAccount extends ConsumerStatefulWidget {
  const MyAccount({super.key});

  @override
  ConsumerState<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends ConsumerState<MyAccount> {
  bool light = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      getUserData();
    });
  }

  final db = FirebaseFirestore.instance;
  Map<String, dynamic> profile = {};

  getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return;
    }

    try {
      DocumentSnapshot userDoc = await db.collection('users').doc(uid).get();

      if (userDoc.exists) {
        setState(() {
          profile = userDoc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      profile = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Account', style: theme.textTheme.bodyMedium),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              GestureDetector(
                onTap: () {
                  if (profile.isNotEmpty) {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed('/profile', arguments: {"profile": profile});
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.colorScheme.surface,
                        radius: 30,
                        child: Image.asset(
                          "assets/launch_icon/my_logo.png",
                          height: 40,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Profile', style: theme.textTheme.bodySmall),
                          Text(
                            '${profile['username'] ?? "quote user"}',
                            style: theme.textTheme.displaySmall,
                          ),
                          Text(
                            'Id:13742857',
                            style: theme.textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed('/downloads'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Downloads', style: theme.textTheme.bodyMedium),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed('/favorites'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Favorites', style: theme.textTheme.bodyMedium),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Notification', style: theme.textTheme.bodyMedium),
                        Switch(
                          value: light,
                          activeColor: theme.colorScheme.primary,
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MaterialButton(
                splashColor: Colors.transparent,
                textColor: const Color.fromARGB(255, 255, 255, 255),
                child: Text('Sign out', style: theme.textTheme.bodySmall),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).popAndPushNamed('/signout');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
