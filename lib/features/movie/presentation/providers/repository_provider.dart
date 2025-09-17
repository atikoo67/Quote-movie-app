import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/cores/utils/constant/app_endpoint.dart';
import 'package:quote/features/movie/data/datasources/remote_movie_data_sourceimpelment.dart';
import 'package:quote/features/movie/data/repositories/movie_repositories_impl.dart';
import 'package:quote/features/movie/domain/repositories/movie_repository.dart';

class RepositoryProvider {
  static final movieRepositoryProvider = Provider<MovieRepository>((ref) {
    final remote = RemoteMovieDataSourceimpelment(
      Dio(
        BaseOptions(
          baseUrl: AppEndPoint.endPoint,
          headers: {'Content-Type': 'application/json'},
        ),
      ),
    );
    return MovieRepositoriesImpl(remote);
  });
}
