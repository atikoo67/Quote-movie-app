import 'package:quote/features/movie/data/models/videomodel.dart';

class VideoModel extends Video {
  VideoModel({
    required super.videokey,
    required super.name,
    required super.type,
    required super.language,
    required super.site,
    required super.official,
    required super.size,
  });
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videokey: json['key'],
      name: json['name'],
      type: json['type'],
      language: json['iso_639_1'],
      site: json['site'],
      official: json['official'],
      size: json['size'],
    );
  }
}
