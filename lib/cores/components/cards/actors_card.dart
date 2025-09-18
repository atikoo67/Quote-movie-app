import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:quote/cores/utils/constant/app_endpoint.dart';

import 'package:quote/features/movie/data/models/actor.dart';

class ActorsCard extends StatelessWidget {
  final Actor actor;
  final double? width;
  const ActorsCard({super.key, required this.actor, this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CircularProfileAvatar(
              borderWidth: 2,
              borderColor: theme.colorScheme.secondary,
              radius: 40,
              initialsText: Text('loading'),
              '${AppEndPoint.imgurl}${actor.profile}',
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 50,
                backgroundColor: theme.scaffoldBackgroundColor,
                child: Center(
                  child: Image.asset(
                    "assets/launch_icon/my_logo.png",
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              style: theme.textTheme.bodySmall,
              actor.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ActorsloadingCard extends StatelessWidget {
  const ActorsloadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 90,
      child: CircularProfileAvatar(
        borderWidth: 1,
        borderColor: theme.colorScheme.surface,

        '',

        backgroundColor: theme.scaffoldBackgroundColor,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: theme.colorScheme.surface,
          child: Center(
            child: Image.asset("assets/launch_icon/my_logo.png", height: 40),
          ),
        ),
      ),
    );
  }
}
