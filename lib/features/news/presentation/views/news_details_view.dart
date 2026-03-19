import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/components/custom_app_bar.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/news/presentation/widgets/read_more_text.dart';

class NewsDetailsView extends StatelessWidget {
  const NewsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        // title: 'News Details',
        actionIconButton: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
        ),
        leadingIconButton: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/png/test_bbc.png',
                        ),
                        radius: 25.r,
                      ),
                      SizedBox(width: 4.w),
                      Column(
                        children: [
                          Text(
                            'BBC News',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: Fonts.semiBold,
                            ),
                          ),
                          Text(
                            '2 hours ago',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      fixedSize: Size(102.w, 34.h),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      'Following',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Fonts.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/2/22/1_Nature_1.png',
                  width: 380.w,
                  height: 248.h,
                  fit: .cover,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Europe',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: Fonts.regular,
                      ),
                    ),
                    ReadMoreText(
                      text:
                          "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil",
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people\'s blood". In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn (\$326bn) this year. Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people\'s blood". In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn (\$326bn) this year. Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people\'s blood". In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn (\$326bn) this year. Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people\'s blood". In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn (\$326bn) this year.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Fonts.regular,
                      ),
                    ),
                    // Text(
                    //   "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil",
                    //   style: TextStyle(
                    //     fontSize: 24.sp,
                    //     fontWeight: Fonts.semiBold,
                    //     // height: ,
                    //   ),
                    //   // maxLines: 2,
                    //   // overflow: TextOverflow.ellipsis,
                    //
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        padding: EdgeInsets.only(left: 24.w,right: 48.w),
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_rounded, color: Colors.red),
                    ),
                    Text('24.5K'),
                  ],
                ),
                SizedBox(width: 30.w),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
                    ),
                    Text('24.5K'),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
              Icons.bookmark_outlined, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
