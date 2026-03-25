import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 9.w),
      child: AppBar(
        backgroundColor: Colors.white,
          leading: Image.asset('assets/images/png/logo.png',width: 150.w,height: 30.h,),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                padding: EdgeInsets.all(8.0),
                  constraints: BoxConstraints(),
                  onPressed: () {},
                  icon: Icon(
                  Icons.notifications_none_outlined,
                size: 28,)),

            ),
          ]

      ),
    );
  }
}