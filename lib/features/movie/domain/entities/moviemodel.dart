import 'package:quote/features/movie/data/models/moviemodel.dart';

class MovieModel extends Movies {
  MovieModel({
    required super.favorite,
    required super.backDropImage,
    required super.title,
    super.thumbnail,
    required super.categories,
    required super.fileId,
    super.size,

    required super.country,
    required super.translator,

    super.year,
    required super.rating,
    required super.description,
  });
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] != null ? json['title'] : json['name'],
      thumbnail: json['poster_path'] != null
          ? json['poster_path']
          : json['backdrop_path'],

      fileId: json['id'],
      size: json['fileSize'] ?? 0,

      categories: json['genre_ids'] != null ? json['genre_ids'] : [16],
      translator: json['original_language'],
      country: json['origin_country'] != null
          ? json['origin_country']
          : ['Unknown'],

      year: json['release_date'] != null ? json['release_date'] : 'Unknown',
      rating: json['vote_average'] ?? 0.0,
      description: json['overview'] != null || json['overview'] != ''
          ? json['overview']
          : 'No overview available',
      backDropImage: json['backdrop_path'],
      favorite: false,
    );
  }
}
