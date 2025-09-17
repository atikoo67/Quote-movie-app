import 'package:quote/features/movie/domain/entities/actors_model.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';
import 'package:quote/features/movie/domain/entities/videomodel.dart';
import 'package:quote/features/movie/domain/repositories/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository repository;

  GetTrendingMovies(this.repository);

  Future<List<MovieModel>> call() {
    return repository.getTrendingMovies();
  }
}

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<List<MovieModel>> call() {
    return repository.getPopularMovies();
  }
}

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<MovieModel>> call() {
    return repository.getMovies();
  }
}

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<List<MovieModel>> call() {
    return repository.getTopRatedMovies();
  }
}

class GetRecommendationMovies {
  final MovieRepository repository;

  GetRecommendationMovies(this.repository);

  Future<List<MovieModel>> call(int id) {
    return repository.getRecommendationMovies(id);
  }
}

class GetSearchMovies {
  final MovieRepository repository;

  GetSearchMovies(this.repository);

  Future<List<MovieModel>> call(String query) {
    return repository.getSearchMovies(query);
  }
}

class GettvSearch {
  final MovieRepository repository;

  GettvSearch(this.repository);

  Future<List<MovieModel>> call(String query) {
    return repository.gettvSearch(query);
  }
}

class GetSimilarMovies {
  final MovieRepository repository;

  GetSimilarMovies(this.repository);

  Future<List<MovieModel>> call(int id) {
    return repository.getSimilarMovies(id);
  }
}

class GetTvSeriesMovies {
  final MovieRepository repository;

  GetTvSeriesMovies(this.repository);

  Future<List<MovieModel>> call() {
    return repository.getTvSeriesMovies();
  }
}

class GetUpComingMovies {
  final MovieRepository repository;

  GetUpComingMovies(this.repository);

  Future<List<MovieModel>> call() {
    return repository.getUpComingMovies();
  }
}

class GetVideo {
  final MovieRepository repository;

  GetVideo(this.repository);

  Future<VideoModel> call(int id) {
    return repository.getVideo(id);
  }
}

class GetActors {
  final MovieRepository repository;

  GetActors(this.repository);

  Future<List<ActorsModel>> call(int id) {
    return repository.getActors(id);
  }
}
