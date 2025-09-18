import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quote/cores/utils/constant/app_endpoint.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/cores/components/cards/moviecard.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/cores/components/cards/actors_card.dart';
import 'package:quote/cores/components/cards/error_cardimage.dart';
import 'package:quote/cores/components/cards/loading_card.dart';
import 'package:quote/cores/components/videoplayer/videoplayer.dart';
import 'package:quote/features/movie/presentation/providers/movie_provider.dart';
import 'package:quote/features/movie/presentation/providers/video_provider.dart/video_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MovieDetail extends ConsumerStatefulWidget {
  final MovieModel movie;
  const MovieDetail({super.key, required this.movie});
  @override
  ConsumerState<MovieDetail> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<MovieDetail> {
  List<MovieModel> seriesMovies = [];
  bool trialler = false;
  bool playclick = false;

  final RefreshController _refreshController = RefreshController();
  Future<String> getactualVideo(String videoKey) async {
    final yt = YoutubeExplode();

    final manifest = await yt.videos.streams.getManifest(
      videoKey,
      ytClients: [YoutubeApiClient.ios, YoutubeApiClient.androidVr],
    );

    // Print all the available streams.

    // Get the audio streams.
    final video = manifest.muxed.withHighestBitrate();

    // Download it
    return video.url.toString();
  }

  Future showsnackbar(message) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green[800],
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  refreshvideo() {
    return {ref.refresh(videoProvider(widget.movie.fileId).future)};
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final videoquery = ref.watch(videoProvider(widget.movie.fileId));
    final recommendedMovies = ref.watch(
      recommendationProvider(widget.movie.fileId),
    );
    final similarMovies = ref.watch(similarMoviesProvider(widget.movie.fileId));
    final actors = ref.watch(actorsProvider(widget.movie.fileId));
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(4),

                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(4),

                      child: Icon(
                        widget.movie.favorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: widget.movie.favorite
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                        size: 30,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        widget.movie.favorite = !widget.movie.favorite;
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showsnackbar("false download button clicked");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(4),

                      child: Icon(
                        Icons.download,
                        color: theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // other details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: trialler
                          ? SafeArea(
                              bottom: false,

                              child: SizedBox(
                                height: ScreenSize.screenHeight(context) * 0.28,
                                child: videoquery.when(
                                  data: (video) {
                                    return FutureBuilder<String>(
                                      future: getactualVideo(
                                        AppEndPoint.videoEndPoint(
                                          video.videokey,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    '${AppEndPoint.imgurl}${widget.movie.backDropImage}',
                                                fit: BoxFit.fill,
                                              ),
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Something is wrong\n Please try",
                                                      style: theme
                                                          .textTheme
                                                          .bodySmall,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    IconButton(
                                                      onPressed: refreshvideo,
                                                      icon: Icon(
                                                        Icons.refresh_outlined,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return SizedBox(
                                          height:
                                              ScreenSize.screenHeight(context) *
                                              0.5,
                                          child: VideoPlayerScreen(
                                            trialler: trialler,
                                            path: snapshot.data!,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  error: (Object error, StackTrace stackTrace) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Something is wrong\n Please try",
                                            style:
                                                theme.textTheme.headlineLarge,
                                            textAlign: TextAlign.center,
                                          ),
                                          IconButton(
                                            onPressed: refreshvideo,
                                            icon: Icon(Icons.refresh_outlined),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  loading: () {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox(
                              height: ScreenSize.screenHeight(context) * 0.55,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: ScreenSize.screenWidth(context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        backgroundBlendMode: BlendMode.screen,
                                        color: theme.colorScheme.surface,
                                        border: BoxBorder.all(
                                          color: theme.colorScheme.shadow,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${AppEndPoint.imgurl}${widget.movie.thumbnail}',
                                        fit: BoxFit.fitWidth,
                                        errorWidget: (context, url, error) =>
                                            ErrorCardimage(),
                                        placeholder: (context, url) =>
                                            LoadingCard(
                                              width: ScreenSize.screenWidth(
                                                context,
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -1,
                                    child: Container(
                                      height: 200,
                                      width: ScreenSize.screenWidth(context),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,

                                          colors: [
                                            theme.scaffoldBackgroundColor,
                                            theme.scaffoldBackgroundColor
                                                .withOpacity(0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        SizedBox(
                                          width:
                                              ScreenSize.screenWidth(context) *
                                              0.6,
                                          child: Text(
                                            widget.movie.title,
                                            style: theme.textTheme.bodyMedium,
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            for (int c = 1; c <= 5; c++)
                                              Icon(
                                                c <= widget.movie.rating / 2
                                                    ? Icons.star
                                                    : c >=
                                                              widget
                                                                      .movie
                                                                      .rating /
                                                                  2 &&
                                                          c - 1 <=
                                                              widget
                                                                      .movie
                                                                      .rating /
                                                                  2
                                                    ? Icons.star_half
                                                    : Icons
                                                          .star_border_outlined,
                                                size: 25,
                                                color:
                                                    c <=
                                                            widget
                                                                    .movie
                                                                    .rating /
                                                                2 ||
                                                        (c >=
                                                                widget
                                                                        .movie
                                                                        .rating /
                                                                    2 &&
                                                            c - 1 <=
                                                                widget
                                                                        .movie
                                                                        .rating /
                                                                    2)
                                                    ? theme.iconTheme.color
                                                    : theme
                                                          .colorScheme
                                                          .secondary,
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () {
                              setState(() {
                                trialler = !trialler;
                              });
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: 120,
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 6,
                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    trialler
                                        ? Icons.videocam_off
                                        : Icons.videocam,
                                    color: theme.colorScheme.tertiary,
                                  ),
                                  Text(
                                    "TRAILLER",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text(
                              'OVERVIEW',
                              style: AppTextStyle.textTheme.headlineLarge,
                            ),
                            widget.movie.description == ''
                                ? Text(
                                    "No available overview",
                                    style: theme.textTheme.displaySmall,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    widget.movie.description,
                                    style: theme.textTheme.bodySmall,
                                  ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Text(
                          'CASTS',
                          style: AppTextStyle.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: actors.when(
                        data: (actorList) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: actorList.isEmpty
                                ? Text(
                                    "No casts found",
                                    style: theme.textTheme.displaySmall,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : SizedBox(
                                    height: 100,

                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: actorList.length,
                                      itemBuilder: (context, index) {
                                        final actor = actorList[index];

                                        return ActorsCard(actor: actor);
                                      },
                                    ),
                                  ),
                          );
                        },
                        error: (Object error, StackTrace stackTrace) {
                          return SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ActorsloadingCard(),
                                );
                              },
                            ),
                          );
                        },
                        loading: () {
                          return SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ActorsloadingCard(),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'RELATED MOVIES',
                          style: AppTextStyle.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: similarMovies.when(
                        data: (movies) {
                          return movies.isEmpty
                              ? Text(
                                  "No related movies found",
                                  style: theme.textTheme.displaySmall,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : SizedBox(
                                  height: 160,
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
                                          ontap: () =>
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      MovieDetail(movie: movie),
                                                ),
                                              ),
                                          movie: movie,
                                          width: 107,
                                        ),
                                      );
                                    },
                                  ),
                                );
                        },
                        error: (Object error, StackTrace stackTrace) {
                          return SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: ErrorCard(width: 107),
                                );
                              },
                            ),
                          );
                        },
                        loading: () {
                          return SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: LoadingCard(width: 107),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'RECOMMENDED MOVIES',
                          style: AppTextStyle.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: recommendedMovies.when(
                        data: (movies) {
                          return movies.isEmpty
                              ? Text(
                                  "No recommended movies found",
                                  style: theme.textTheme.displaySmall,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : SizedBox(
                                  height: 160,
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
                                          ontap: () =>
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      MovieDetail(movie: movie),
                                                ),
                                              ),
                                          movie: movie,
                                          width: 107,
                                        ),
                                      );
                                    },
                                  ),
                                );
                        },
                        error: (Object error, StackTrace stackTrace) {
                          return SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: ErrorCard(width: 107),
                                );
                              },
                            ),
                          );
                        },
                        loading: () {
                          return SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: LoadingCard(width: 107),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
