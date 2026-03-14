import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_theme.dart';

import '../../../core/components/custom_app_bar.dart';



class HomePage extends StatefulWidget implements PreferredSizeWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<String> newsList = [
    "Football News",
    "Tech News",
    "Political News",
    "Beauty And woman"
  ];
  List<String> filterNews = [];
  void search(String query){
    final suggestion = newsList.where((news) {
      final result = news.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
      }).toList();
    setState(() {
      filterNews = suggestion;
    });
  }


  @override
  void initState() {
    super.initState();
   
      filterNews = newsList;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: searchController,
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.tune_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
            
                Expanded(
                  child: ListView.builder(
                    itemCount: filterNews.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filterNews[index]),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Branding",
                    style: AppTheme.font16BlackW600
                    ),
                    Text(
                      'See all',
                    style:AppTheme.font14Grey4ERegular ,)
            
                  ]
            
                )
            
              ],
            ),
          ),
        ),
    );
  }
}
