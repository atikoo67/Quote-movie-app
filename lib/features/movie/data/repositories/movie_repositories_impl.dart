import 'package:quote/features/movie/data/datasources/remote_movie_data_source.dart';
import 'package:quote/features/movie/domain/entities/actors_model.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/domain/entities/videomodel.dart';
import 'package:quote/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoriesImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  MovieRepositoriesImpl(this.remote);
  @override
  Future<List<MovieModel>> getPopularMovies() {
    return remote.fetchPopularMovies();
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() {
    return remote.fetchTopRatedMovies();
  }

  @override
  Future<List<ActorsModel>> getActors(int id) {
    return remote.fetchActors(id);
  }

  @override
  Future<List<MovieModel>> gettvSearch(String query) {
    return remote.fetchtvsearch(query);
  }

  @override
  Future<List<MovieModel>> getSearchMovies(String query) {
    return remote.fetchmoviesearch(query);
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() {
    return remote.fetchTrendingMovies();
  }

  @override
  Future<List<MovieModel>> getMovies() {
    return remote.fetchMovies();
  }

  @override
  Future<List<MovieModel>> getTvSeriesMovies() {
    return remote.fetchTvSeriesMovies();
  }

  @override
  Future<List<MovieModel>> getUpComingMovies() {
    return remote.fetchUpComingMovies();
  }

  @override
  Future<VideoModel> getVideo(int id) {
    return remote.fetchVideo(id);
  }

  @override
  Future<List<MovieModel>> getRecommendationMovies(int id) {
    return remote.fetchRecommendationMovies(id);
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int id) {
    return remote.fetchSimilarMovies(id);
  }
}
