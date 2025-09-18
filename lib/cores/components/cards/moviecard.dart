import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quote/cores/utils/constant/app_endpoint.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/cores/components/cards/loading_card.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final double? width;
  final void Function()? ontap;
  const MovieCard({
    super.key,
    required this.movie,
    this.width,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          backgroundBlendMode: BlendMode.screen,
          color: theme.colorScheme.surface,
          border: BoxBorder.all(
            width: 4,
            color: theme.colorScheme.surface,
            style: BorderStyle.solid,
          ),
        ),

        child: CachedNetworkImage(
          imageUrl: '${AppEndPoint.imgurl}${movie.thumbnail}',
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => SizedBox(
            width: width,
            child: Image.asset("assets/launch_icon/my_logo.png", height: 40),
          ),
          placeholder: (context, url) => LoadingCard(width: width),
        ),
      ),
    );
  }
}
