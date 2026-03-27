import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/features/BookMark/presentation/views/book_mark_view.dart';
import 'package:news_app/features/Explore/data/repo/explore_repo_implementation.dart';
import 'package:news_app/features/Explore/network/dio_client.dart';
import 'package:news_app/features/Explore/presentation/bloc/explore_cubit.dart';
import 'package:news_app/features/Explore/presentation/view/explore_view.dart';
import 'package:news_app/features/profile/presentation/profile_view.dart';

import '../../features/HomePage/presentation/home_page.dart';

  class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentIndex = 0;


<<<<<<< Updated upstream
  final List<Widget> pages = [
    HomePage(),
     Explore(),
    // BookmarkPage(),
=======
  late final List<Widget> pages = [
    BlocProvider(
        create: (context) => NewsBloc(
          UseCaseNews(RepoImpl()),
        )..add(FetchNews(category: null)),
        child: HomePage()),
    BlocProvider(
      create: (_) => ExploreCubit(
        ExploreRepositoryImpl(client: DioClient()),
      )..getExplores(),
      child: Explore(),
    ),
    BookMarkView(),
    ProfileView(),
>>>>>>> Stashed changes
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
            if (index < pages.length) {
              currentIndex = index;
            }
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",

             activeIcon: Icon(
            Icons.home,
            color: AppColors.navBarBlue,

          ),),

          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
            activeIcon: Icon(
            Icons.explore,
            color: AppColors.navBarBlue,
          ),
          ),

           BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(
            Icons.bookmark,
            color: AppColors.navBarBlue,
          ),
            label: "Bookmark",
          ),

           BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,),
            activeIcon: Icon(
            Icons.person,
            color: AppColors.navBarBlue,
          ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}