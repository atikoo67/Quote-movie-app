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
      appBar: AppBar(
        title: Text('Profile', style: theme.textTheme.bodyMedium),
        centerTitle: true,
      ),
      body: Column(
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
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
                    Text(
                      '${profile['username']}',
                      style: theme.textTheme.bodySmall,
                    ),
                    Text('Id:13742857', style: theme.textTheme.displaySmall),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 10,
              children: [
                Text('User email', style: theme.textTheme.bodySmall),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),

                  child: Text(
                    "${profile['email']}",
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 10,
              children: [
                Text('Username', style: theme.textTheme.bodySmall),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),

                  child: Text(
                    "${profile["username"]}",
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 10,
              children: [
                Text('Phone Number', style: theme.textTheme.bodySmall),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),

                  child: Text(
                    "${profile["phonenumber"]}",
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
