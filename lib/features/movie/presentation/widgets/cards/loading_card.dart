import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  final double? width;
  const LoadingCard({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ClipRect(
          clipBehavior: Clip.hardEdge,
          child: Shimmer.fromColors(
            direction: ShimmerDirection.ttb,
            baseColor: theme.colorScheme.surface,
            highlightColor: theme.colorScheme.secondary,
            child: Container(
              width: width!,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        Center(
          child: Image.asset("assets/launch_icon/my_logo.png", height: 40),
        ),
      ],
    );
  }
}

class ErrorCard extends StatelessWidget {
  final double width;
  const ErrorCard({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset("assets/launch_icon/my_logo.png", height: 40),
        ),
        Text("Unable to Load", style: theme.textTheme.bodySmall),
      ],
    );
  }
}
