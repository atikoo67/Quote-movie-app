import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/cores/widgets/searchcard.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';

class SearchResultsList extends ConsumerStatefulWidget {
  final AsyncValue<List<MovieModel>> movies;

  const SearchResultsList({super.key, required this.movies});

  @override
  ConsumerState<SearchResultsList> createState() => _SearchResultsListState();
}

class _SearchResultsListState extends ConsumerState<SearchResultsList> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        widget.movies.when(
          data: (movies) {
            return movies.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "No Movies Found",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(1),
                    sliver: SliverList.builder(
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, int index) {
                        final movie = movies[index];

                        return SearchCard(movie: movie);
                      },
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
            padding: const EdgeInsets.all(1),
            sliver: SliverList.builder(
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return SearchCardLoading();
              },
            ),
          ),
        ),
      ],
    );
  }
}
