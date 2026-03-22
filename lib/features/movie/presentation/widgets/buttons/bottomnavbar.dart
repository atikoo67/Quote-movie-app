import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:quote/features/movie/presentation/pages/home_page.dart';
import 'package:quote/features/movie/presentation/pages/search_page.dart';
import 'package:quote/features/movie/presentation/pages/series_page.dart';
import 'package:quote/features/movie/presentation/pages/myaccount.dart';

class BottomNavBar extends StatefulWidget {
  final dynamic Function(int) onTabChangedListener;
  const BottomNavBar({super.key, required this.onTabChangedListener});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PersistentTabView(
      backgroundColor: theme.colorScheme.surface,
      context,
      navBarStyle: NavBarStyle.style3,
      hideNavigationBarWhenKeyboardAppears: true,
      resizeToAvoidBottomInset: false,
      screens: [HomePage(), SeriesPage(), SearchField(), MyAccount()],
      items: [
        PersistentBottomNavBarItem(
          inactiveIcon: Icon(Icons.home_outlined),
          icon: Icon(Icons.home_rounded),
          iconSize: 30,
          opacity: 0.8,
          activeColorPrimary: theme.colorScheme.tertiary,
          inactiveColorPrimary: theme.colorScheme.primary,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: Icon(Icons.movie_creation_outlined),
          icon: Icon(Icons.movie_sharp),
          iconSize: 30,
          opacity: 0.8,
          activeColorPrimary: theme.colorScheme.tertiary,
          inactiveColorPrimary: theme.colorScheme.primary,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          iconSize: 30,
          opacity: 0.8,
          activeColorPrimary: theme.colorScheme.tertiary,
          inactiveColorPrimary: theme.colorScheme.primary,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: Icon(Icons.person_2_outlined),
          icon: Icon(Icons.person_2),
          iconSize: 30,
          opacity: 0.8,
          activeColorPrimary: theme.colorScheme.tertiary,
          inactiveColorPrimary: theme.colorScheme.primary,
        ),
      ],
    );
  }
}
