import 'package:dio/dio.dart';
import 'package:quote/cores/utils/constant/api.dart';
import 'package:quote/features/movie/data/datasources/remote_movie_data_source.dart';
import 'package:quote/features/movie/domain/entities/actors_model.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/domain/entities/videomodel.dart';

class RemoteMovieDataSourceimpelment implements MovieRemoteDataSource {
  final Dio dio;
  RemoteMovieDataSourceimpelment(this.dio);

  final queryparameter = {'api_key': ApiKey.apiKey};
  @override
  Future<List<MovieModel>> fetchPopularMovies() async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: queryparameter,
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<MovieModel>> fetchTopRatedMovies() async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: queryparameter,
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<MovieModel>> fetchTrendingMovies() async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: queryparameter,
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<MovieModel>> fetchTvSeriesMovies() async {
    final response = await dio.get(
      '/tv/popular',
      queryParameters: queryparameter,
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<MovieModel>> fetchUpComingMovies() async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: queryparameter,
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<MovieModel>> fetchMovies() async {
    final response = await dio.get(
      '/discover/movie',
      queryParameters: queryparameter,
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<VideoModel> fetchVideo(int id) async {
    final response = await dio.get(
      '/movie/$id/videos',
      queryParameters: queryparameter,
    );

    final results = response.data['results'] as List;

    return VideoModel.fromJson(results[0]);
  }

  @override
  Future<List<MovieModel>> fetchRecommendationMovies(int id) async {
    final response = await dio.get(
      '/movie/$id/recommendations',
      queryParameters: queryparameter,
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<MovieModel>> fetchSimilarMovies(int id) async {
    final response = await dio.get(
      '/movie/$id/similar',
      queryParameters: queryparameter,
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ActorsModel>> fetchActors(int id) async {
    final response = await dio.get(
      '/movie/$id/credits',
      queryParameters: queryparameter,
    );
    return (response.data['cast'] as List)
        .map((json) => ActorsModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<MovieModel>> fetchmoviesearch(String query) async {
    final response = await dio.get(
      '/search/movie?query=$query&include_adult=false&language=en-US&page=1&api_key=${ApiKey.apiKey}',
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<MovieModel>> fetchtvsearch(String query) async {
    final response = await dio.get(
      '/search/tv?query=$query&include_adult=false&language=en-US&page=1&api_key=${ApiKey.apiKey}',
    );
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }
}
