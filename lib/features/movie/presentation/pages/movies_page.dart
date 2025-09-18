import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quote/cores/components/lists/moviegriding.dart';
import 'package:quote/cores/components/textfields/mytextfield.dart';
import 'package:quote/cores/utils/constant/strings.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/presentation/providers/movie_provider.dart';

class MoviePage extends ConsumerStatefulWidget {
  const MoviePage({super.key});
  @override
  ConsumerState<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  late String selected = options.first;
  TextEditingController? controller;
  List options = ["All", "Drama", "Romance"];
  List<MovieModel> movies = [];

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    connect();
  }

  connect() {
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(trendingMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset("assets/launch_icon/my_logo.png", height: 50),

            Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () => connect(),

        enablePullDown: true,

        child: Column(
          children: [
            MyTextField(label: "search", controller: controller),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      options,
                      style: TextStyle(
                        fontSize: isActive ? 15 : 14,
                        fontWeight: FontWeight.normal,
                        color: isActive
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            Expanded(child: MovieGrid(movies: movie)),
          ],
        ),
      ),
    );
  }
}
