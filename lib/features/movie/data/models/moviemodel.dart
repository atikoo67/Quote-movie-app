class Movies {
  final String title;
  final String? thumbnail;
  final String? backDropImage;
  final List categories;
  final int? size;
  final List country;
  final String? translator;
  final int fileId;

  String? year;
  double rating;
  String description;
  bool favorite = false;

  Movies({
    required this.favorite,
    required this.backDropImage,
    required this.title,
    this.thumbnail,
    required this.categories,
    required this.fileId,
    this.size,

    required this.country,
    required this.translator,

    this.year,
    required this.rating,
    required this.description,
  });
}
