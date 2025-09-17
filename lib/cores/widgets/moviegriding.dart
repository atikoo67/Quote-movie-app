import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/cores/widgets/moviecard.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/presentation/components/loading_card.dart';
import 'package:quote/features/movie/presentation/pages/movie_detail.dart';

class MovieGrid extends ConsumerStatefulWidget {
  final AsyncValue<List<MovieModel>> movies;

  const MovieGrid({super.key, required this.movies});

  @override
  ConsumerState<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends ConsumerState<MovieGrid> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        widget.movies.when(
          data: (movies) {
            return SliverPadding(
              padding: const EdgeInsets.all(1),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final movie = movies[index];

                  return MovieCard(
                    movie: movie,
                    width: 100,
                    ontap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetail(movie: movie),
                      ),
                    ),
                  );
                }, childCount: movies.length),
              ),
            );
          },
          error: (e, _s) {
            print(e.toString() + _s.toString());
            return SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(height: ScreenSize.screenHeight(context) * 0.3),
                  Text("Oops! Something went wrong. Please try again."),
                ],
              ),
            );
          },
          loading: () => SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return LoadingCard(width: 100);
              }, childCount: 20),
            ),
          ),
        ),
      ],
    );
  }
}
