import 'package:quote/features/movie/domain/entities/actors_model.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/domain/entities/videomodel.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getUpComingMovies();
  Future<List<MovieModel>> getTvSeriesMovies();
  Future<List<MovieModel>> getMovies();
  Future<VideoModel> getVideo(int id);
  Future<List<MovieModel>> getRecommendationMovies(int id);
  Future<List<MovieModel>> getSearchMovies(String query);
  Future<List<MovieModel>> gettvSearch(String query);
  Future<List<MovieModel>> getSimilarMovies(int id);
  Future<List<ActorsModel>> getActors(int id);
}
