import 'package:flutter/material.dart';
import 'package:quote/cores/components/buttons/bottomnavbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selecteditem = 0;
  navigateBottomBar(index) {
    setState(() {
      selecteditem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        bottomNavigationBar: BottomNavBar(
          onTabChangedListener: (index) {
            (index) => navigateBottomBar(index);
          },
        ),
      ),
    );
  }
}
