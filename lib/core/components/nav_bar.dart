import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/features/Explore/presentation/view/explore_view.dart';

import '../../features/HomePage/presentation/home_page.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    Explore(),
    // BookmarkPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppColors.navBarBlue,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",

            activeIcon: Icon(Icons.home, color: AppColors.navBarBlue),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
            activeIcon: Icon(Icons.explore, color: AppColors.navBarBlue),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark, color: AppColors.navBarBlue),
            label: "Bookmark",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person, color: AppColors.navBarBlue),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
