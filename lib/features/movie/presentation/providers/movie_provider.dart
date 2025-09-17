import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/features/movie/domain/entities/actors_model.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/presentation/providers/usecase_provider.dart';

// trending movies provider
final searchQueryProvider = StateProvider<String>((ref) => '');
final trendingMoviesProvider = FutureProvider((ref) {
  final useCase = ref.watch(UsecaseProvider.getTrendingMoviesUseCaseProvider);
  return useCase();
});

// top rated movies provider
final topRatedMoviesProvider = FutureProvider((ref) {
  final useCase = ref.watch(UsecaseProvider.getTopRatedMoviesUseCaseProvider);
  return useCase();
});

// popular movies provider

final popularMoviesProvider = FutureProvider((ref) {
  final useCase = ref.watch(UsecaseProvider.getPopularMoviesUseCaseProvider);
  return useCase();
});

// up coming movies  provider

final upcomingMoviesProvider = FutureProvider((ref) {
  final useCase = ref.watch(UsecaseProvider.getUpComingMoviesUseCaseProvider);
  return useCase();
});

// tv series  provider

final tvSeriesMoviesProvider = FutureProvider((ref) {
  final useCase = ref.watch(UsecaseProvider.getTvSeriesMoviesUseCaseProvider);
  return useCase();
});

// all movies provider

final moviesProvider = FutureProvider((ref) {
  final useCase = ref.watch(UsecaseProvider.getMoviesUseCaseProvider);
  return useCase();
});

// recommendation movies provider

final recommendationProvider = FutureProvider.family<List<MovieModel>, int>((
  ref,
  id,
) {
  final useCase = ref.watch(UsecaseProvider.getRecommendationUseCaseProvider);
  return useCase(id);
});

// similar movies provider
final similarMoviesProvider = FutureProvider.family<List<MovieModel>, int>((
  ref,
  id,
) {
  final useCase = ref.watch(UsecaseProvider.getSimilarUseCaseProvider);
  return useCase(id);
});

final searchmovieProvider = FutureProvider<List<MovieModel>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final useCase = ref.watch(UsecaseProvider.getSearchMovieUseCaseProvider);
  return await useCase(query);
});

final searchtvProvider = FutureProvider<List<MovieModel>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final useCase = ref.watch(UsecaseProvider.gettvSearchUseCaseProvider);
  return await useCase(query);
});

final actorsProvider = FutureProvider.family<List<ActorsModel>, int>((ref, id) {
  final useCase = ref.watch(UsecaseProvider.getActorsUseCaseProvider);
  return useCase(id);
});
