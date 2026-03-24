import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/features/BookMark/presentation/views/book_mark_view.dart';
import 'package:news_app/features/Explore/presentation/view/explore_view.dart';

import '../../features/HomePage/Data/RepositryImp/repo_imp.dart';
import '../../features/HomePage/Domain/UsesCase/use_case_news.dart';
import '../../features/HomePage/presentation/home_page.dart';
import '../../features/HomePage/presentation/logic/news_bloc.dart';
import '../../features/HomePage/presentation/logic/news_event.dart';

  class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentIndex = 0;


  late final List<Widget> pages = [
    BlocProvider(
        create: (context) => NewsBloc(
          UseCaseNews(RepoImpl()),
        )..add(FetchNews(category: null)),
        child: HomePage()),
    Explore(),
    BookMarkView(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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
            backgroundColor: Colors.white,

             activeIcon: Icon(
            Icons.home,
            color: AppColors.navBarBlue,

          ),),

          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.explore),
            label: "Explore",
            activeIcon: Icon(
            Icons.explore,
            color: AppColors.navBarBlue,
          ),
          ),

           BottomNavigationBarItem(
             backgroundColor: Colors.white,
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(
            Icons.bookmark,
            color: AppColors.navBarBlue,
          ),
            label: "Bookmark",
          ),

           BottomNavigationBarItem(
             backgroundColor: Colors.white,
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