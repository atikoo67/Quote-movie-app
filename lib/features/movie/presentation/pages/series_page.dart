import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/cores/widgets/moviegriding.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/presentation/providers/movie_provider.dart';

class SeriesPage extends ConsumerStatefulWidget {
  const SeriesPage({super.key});
  @override
  ConsumerState<SeriesPage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<SeriesPage> {
  late String selected = options.first;

  List<MovieModel> allMovies = [];

  List options = ["Movies", "Tv Series"];
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
  }

  refresh() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final movies = ref.watch(moviesProvider);
    final tvSeries = ref.watch(tvSeriesMoviesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/launch_icon/my_logo.png", height: 40),
            Text("Movies", style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: refresh,

        enablePullDown: true,

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: options.map((options) {
                final bool isActive = selected == options;

                return GestureDetector(
                  onTap: () {
                    if (selected != options) {
                      setState(() {
                        selected = options;
                      });
                    }
                  },
                  child: SizedBox(
                    width: ScreenSize.screenWidth(context) * 0.5,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          options,
                          style: isActive
                              ? theme.textTheme.headlineLarge
                              : theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            Expanded(
              child: MovieGrid(
                movies: selected == 'Movies' ? movies : tvSeries,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
