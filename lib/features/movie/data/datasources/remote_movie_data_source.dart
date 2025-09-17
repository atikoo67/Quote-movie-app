import 'package:quote/features/movie/data/models/videomodel.dart';
import 'package:quote/features/movie/domain/entities/actors_model.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/domain/entities/videomodel.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchTrendingMovies();
  Future<List<MovieModel>> fetchPopularMovies();
  Future<List<MovieModel>> fetchTopRatedMovies();
  Future<List<MovieModel>> fetchUpComingMovies();
  Future<List<MovieModel>> fetchTvSeriesMovies();
  Future<List<MovieModel>> fetchRecommendationMovies(int id);
  Future<List<MovieModel>> fetchSimilarMovies(int id);
  Future<List<MovieModel>> fetchtvsearch(String query);
  Future<List<MovieModel>> fetchmoviesearch(String query);
  Future<List<MovieModel>> fetchMovies();
  Future<VideoModel> fetchVideo(int id);
  Future<List<ActorsModel>> fetchActors(int id);
}
