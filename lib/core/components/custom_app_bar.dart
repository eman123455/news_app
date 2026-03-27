import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notification_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 12.w),
      child: AppBar(
          leading: Image.asset('assets/images/logo.png',width: 99.w,height: 30.h,),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                padding: EdgeInsets.all(10.0),
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationScreen()),
                    );
                  },
                  icon: Icon(
                  Icons.notifications_none_outlined,
                size: 28,)),

            ),
          ]

      ),
    );
  }
}
=======

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconButton? leadingIconButton;
  final IconButton? actionIconButton;

  const CustomAppBar({
    this.title,
    this.leadingIconButton,
    this.actionIconButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: leadingIconButton,
      title: Text(title ?? ''),
      centerTitle: true,
      actions: [?actionIconButton],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
>>>>>>> Stashed changes
