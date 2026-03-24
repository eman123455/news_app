import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/BookMark/presentation/views/bookmark_item.dart';

class BookMarkView extends StatefulWidget {
  const BookMarkView({super.key});

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Bookmark',
                  style: TextStyle(fontWeight: Fonts.bold, fontSize: 32.sp),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: searchController,
                  onChanged: (changedValue) {},
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    // suffixIcon: Icon(Icons.tune_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    return BookmarkItem();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
