import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:quote/cores/utils/constant/app_endpoint.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/presentation/pages/movie_detail.dart';
import 'package:shimmer/shimmer.dart';

class MovieAutoSlider extends StatelessWidget {
  final MovieModel movie;
  const MovieAutoSlider({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: MovieDetail(movie: movie),
        withNavBar: false,
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: '${AppEndPoint.imgurl}${movie.backDropImage!}',
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => ClipRect(
              clipBehavior: Clip.hardEdge,
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ttb,
                baseColor: theme.colorScheme.surface,
                highlightColor: theme.colorScheme.secondary,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            placeholder: (context, url) => ClipRect(
              clipBehavior: Clip.hardEdge,
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ttb,
                baseColor: theme.colorScheme.surface,
                highlightColor: theme.colorScheme.secondary,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            child: Container(
              height: 180,
              width: ScreenSize.screenWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,

                  colors: [
                    theme.scaffoldBackgroundColor,
                    theme.scaffoldBackgroundColor.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    movie.title,
                    style: AppTextStyle.textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          for (int c = 1; c <= 5; c++)
                            Icon(
                              c <= movie.price / 2
                                  ? Icons.star
                                  : c >= movie.price / 2 &&
                                        c - 1 <= movie.price / 2
                                  ? Icons.star_half
                                  : Icons.star_border_outlined,
                              size: 20,
                              color:
                                  c <= movie.price / 2 ||
                                      (c >= movie.price / 2 &&
                                          c - 1 <= movie.price / 2)
                                  ? theme.iconTheme.color
                                  : theme.colorScheme.secondary,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        movie.year!,
                        style: AppTextStyle.textTheme.displaySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
