import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote/cores/components/lists/searchlists.dart';
import 'package:quote/features/movie/presentation/providers/movie_provider.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});
  @override
  ConsumerState<SearchField> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<SearchField> {
  final TextEditingController controller = TextEditingController();

  bool isSearchActive = false;
  final List options = ['Tv Series', "Movies"];
  late String selected;
  Timer? _debounce;

  @override
  void initState() {
    selected = options.first;
    super.initState();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).state = value.trim();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final movies = selected == 'Movies'
        ? ref.watch(searchmovieProvider)
        : ref.watch(searchtvProvider);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: TextField(
                onChanged: _onSearchChanged,
                controller: controller,
                style: theme.textTheme.titleSmall,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  label: Text('Search'),
                  labelStyle: theme.textTheme.titleSmall,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: options.map((option) {
                  final bool isActive = selected == option;

                  return GestureDetector(
                    onTap: () {
                      if (selected != option) {
                        setState(() {
                          selected = option;
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        option,
                        style: isActive
                            ? theme.textTheme.headlineLarge
                            : theme.textTheme.bodySmall,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            controller.text.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "Search your best movies/series",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  )
                : Expanded(child: SearchResultsList(movies: movies)),
          ],
        ),
      ),
    );
  }
}
