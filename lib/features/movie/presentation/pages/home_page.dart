import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quote/cores/utils/constant/colors.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/cores/utils/constant/strings.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/cores/components/cards/moviecard.dart';
import 'package:quote/cores/components/cards/loading_card.dart';
import 'package:quote/cores/components/cards/movieauto_slider.dart';
import 'package:quote/features/movie/presentation/pages/movie_detail.dart';
import 'package:quote/features/movie/presentation/pages/seemore.dart';
import 'package:quote/features/movie/presentation/providers/movie_provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<HomePage> {
  TextEditingController? controller;
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    super.initState();
  }

  refreshpage() {
    return setState(() {
      ref.refresh(trendingMoviesProvider.future);
      ref.refresh(topRatedMoviesProvider.future);
      ref.refresh(upcomingMoviesProvider.future);
      ref.refresh(tvSeriesMoviesProvider.future);
      ref.refresh(popularMoviesProvider.future);
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trending = ref.watch(trendingMoviesProvider);
    final topRated = ref.watch(topRatedMoviesProvider);
    final upComing = ref.watch(upcomingMoviesProvider);
    final tvSeries = ref.watch(tvSeriesMoviesProvider);
    final popular = ref.watch(popularMoviesProvider);
    final movies = [trending, popular, topRated, upComing, tvSeries];
    final movietype = [
      'Trending',
      'Popular',
      'Top Rated',
      'Up Coming',
      'Tv Series',
    ];
    return Scaffold(
      appBar: AppBar(
        primary: false,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/launch_icon/my_logo.png", height: 40),
            Text(AppStrings.appName, style: AppTextStyle.textTheme.bodyLarge),
          ],
        ),

        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: refreshpage,
        child: CustomScrollView(
          slivers: [
            trending.when(
              data: (movies) => SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CarouselSlider.builder(
                    itemCount: 6,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,

                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return MovieAutoSlider(movie: movies[index]);
                    },
                  ),
                ),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(child: Text('⚠️Unable to Load! ')),
                  ),
                ),
              ),
              loading: () => SliverToBoxAdapter(
                child: CarouselSlider.builder(
                  itemCount: 3,
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    disableCenter: true,
                    enableInfiniteScroll: true,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          ClipRect(
                            clipBehavior: Clip.hardEdge,
                            child: Shimmer.fromColors(
                              direction: ShimmerDirection.ttb,
                              baseColor: theme.colorScheme.surface,
                              highlightColor: theme.colorScheme.secondary,
                              child: Container(
                                width: ScreenSize.screenWidth(context),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              "assets/launch_icon/my_logo.png",
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(color: theme.colorScheme.surface, thickness: 2),
            ),
            SliverList.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            movietype[index],
                            style: AppTextStyle.textTheme.titleMedium,
                          ),
                          GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: SeeMore(filteredMovies: movies[index]),
                                withNavBar: false,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'See more',
                                  style: AppTextStyle.textTheme.headlineLarge,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: AppColor.link,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    movies[index].when(
                      data: (movies) => SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: MovieCard(
                                movie: movie,
                                width: 120,
                                ontap: () =>
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      withNavBar: false,
                                      screen: MovieDetail(movie: movie),
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      loading: () => SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: LoadingCard(width: 106),
                            );
                          },
                        ),
                      ),
                      error: (e, _) {
                        return Center(child: Text("Unable to Load"));
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
