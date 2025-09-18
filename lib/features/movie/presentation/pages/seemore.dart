import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/cores/utils/constant/strings.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/cores/components/lists/moviegriding.dart';
import 'package:quote/features/movie/domain/entities/moviemodel.dart';

class SeeMore extends StatefulWidget {
  final AsyncValue<List<MovieModel>> filteredMovies;

  const SeeMore({super.key, required this.filteredMovies});

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Image.asset("assets/launch_icon/my_logo.png", height: 40),
            Text(AppStrings.appName, style: AppTextStyle.textTheme.bodyLarge),
          ],
        ),
      ),
      body: MovieGrid(movies: widget.filteredMovies),
    );
  }
}
