import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/cores/utils/constant/app_endpoint.dart';
import 'package:quote/features/movie/data/datasources/remote_movie_data_sourceimpelment.dart';
import 'package:quote/features/movie/data/models/videomodel.dart';
import 'package:quote/features/movie/data/repositories/movie_repositories_impl.dart';
import 'package:quote/features/movie/domain/repositories/movie_repository.dart';
import 'package:quote/features/movie/domain/usecases/get_movies.dart';

final videoProvider = FutureProvider.family<Video, int>((ref, id) {
  final useCase = ref.watch(getvideoProvider);
  return useCase(id);
});

final videoRepositoryProvider = Provider<MovieRepository>((ref) {
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

final getvideoProvider = Provider((ref) {
  final repo = ref.watch(videoRepositoryProvider);
  return GetVideo(repo);
});
