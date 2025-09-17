import 'package:quote/features/movie/data/models/actor.dart';
import 'package:quote/features/movie/data/models/videomodel.dart';

class ActorsModel extends Actor {
  ActorsModel({
    required super.id,
    required super.profile,
    required super.department,
    required super.popularity,
    required super.gender,
    required super.character,
    required super.name,
  });
  factory ActorsModel.fromJson(Map<String, dynamic> json) {
    return ActorsModel(
      id: json['id'],
      profile: json['profile_path'],
      department: json['known_for_department'],
      popularity: json['popularity'],
      gender: json['gender'],
      character: json['character'],
      name: json['name'],
    );
  }
}
