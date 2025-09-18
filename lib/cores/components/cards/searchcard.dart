import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:quote/cores/utils/constant/app_endpoint.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/cores/components/cards/loading_card.dart';
import 'package:quote/features/movie/presentation/pages/movie_detail.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
// ignore: must_be_immutable
class SearchCard extends StatefulWidget {
  MovieModel movie;

  SearchCard({super.key, required this.movie});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
        context,
        screen: MovieDetail(movie: widget.movie),
        withNavBar: false,
        settings: RouteSettings(name: '/your_new_screen'),
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: '${AppEndPoint.imgurl}${widget.movie.thumbnail}',

                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => LoadingCard(width: 70),
                errorWidget: (context, url, error) => SizedBox(
                  width: 70,
                  height: 100,
                  child: Image.asset(
                    "assets/launch_icon/my_logo.png",
                    height: 40,
                    width: 40,

                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  widget.movie.description == ''
                      ? Text(
                          "No available overview",
                          style: theme.textTheme.displaySmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          widget.movie.description,
                          style: theme.textTheme.displaySmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (int c = 1; c <= 5; c++)
                        Icon(
                          c <= widget.movie.rating / 2
                              ? Icons.star
                              : c >= widget.movie.rating / 2 &&
                                    c - 1 <= widget.movie.rating / 2
                              ? Icons.star_half
                              : Icons.star_border_outlined,
                          size: 15,
                          color:
                              c <= widget.movie.rating / 2 ||
                                  (c >= widget.movie.rating / 2 &&
                                      c - 1 <= widget.movie.rating / 2)
                              ? theme.iconTheme.color
                              : theme.colorScheme.secondary,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                widget.movie.favorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: widget.movie.favorite
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary,
                size: 25,
              ),
              onPressed: () {
                setState(() {
                  widget.movie.favorite = !widget.movie.favorite;
                });
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchCardLoading extends StatelessWidget {
  const SearchCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Shimmer.fromColors(
            direction: ShimmerDirection.ttb,
            baseColor: theme.colorScheme.surface,
            highlightColor: theme.colorScheme.secondary,
            child: Container(
              width: 70,
              height: 100,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Image.asset(
                  "assets/launch_icon/my_logo.png",
                  height: 30,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: theme.colorScheme.surface,
                  highlightColor: theme.colorScheme.secondary,
                  child: Container(
                    height: 15,
                    width: ScreenSize.screenWidth(context) * 0.4,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                // Subtitle shimmer
                Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: theme.colorScheme.surface,
                  highlightColor: theme.colorScheme.secondary,
                  child: Container(
                    height: 10,
                    width: ScreenSize.screenWidth(context) * 0.6,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: theme.colorScheme.surface,
                  highlightColor: theme.colorScheme.secondary,
                  child: Container(
                    height: 10,
                    margin: const EdgeInsets.only(bottom: 10),
                    width: ScreenSize.screenWidth(context) * 0.6,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: theme.colorScheme.surface,
                  highlightColor: theme.colorScheme.secondary,
                  child: Container(
                    height: 13,
                    width: ScreenSize.screenWidth(context) * 0.3,

                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Shimmer.fromColors(
            direction: ShimmerDirection.ttb,
            baseColor: theme.colorScheme.surface,
            highlightColor: theme.colorScheme.secondary,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
