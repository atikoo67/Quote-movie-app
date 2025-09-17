import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/features/movie/domain/usecases/get_movies.dart';
import 'package:quote/features/movie/presentation/providers/repository_provider.dart';

class UsecaseProvider {
  static final getTrendingMoviesUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetTrendingMovies(repo);
  });
  static final getUpComingMoviesUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetUpComingMovies(repo);
  });
  static final getPopularMoviesUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetPopularMovies(repo);
  });
  static final getTvSeriesMoviesUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetTvSeriesMovies(repo);
  });
  static final getTopRatedMoviesUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetTopRatedMovies(repo);
  });
  static final getMoviesUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetMovies(repo);
  });
  static final getRecommendationUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetRecommendationMovies(repo);
  });
  static final getSimilarUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetSimilarMovies(repo);
  });
  static final getActorsUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetActors(repo);
  });
  static final getSearchMovieUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GetSearchMovies(repo);
  });
  static final gettvSearchUseCaseProvider = Provider((ref) {
    final repo = ref.watch(RepositoryProvider.movieRepositoryProvider);
    return GettvSearch(repo);
  });
}
