import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/app/app_cubit/app_cubit.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/features/settings/presentation/widgets/settings_info%20_row.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyle.text16Regular),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.grey4E),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SettingsInfoRow(
              prefexIcon: Icons.notifications_none_outlined,
              text: 'Notification',
              trailing: Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            SizedBox(height: 5.h),
            SettingsInfoRow(
              prefexIcon: Icons.lock_outline,
              text: 'Security',
              trailing: Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            SizedBox(height: 5.h),
            SettingsInfoRow(
              prefexIcon: Icons.help_outline,
              text: 'Help',
              trailing: Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            SizedBox(height: 5.h),
            // SettingsInfoRow(
            //   prefexIcon: Icons.edit_outlined,
            //   text: 'Edit Profile',
            //   trailing: Icon(Icons.chevron_right),
            //   onPressed: () {
            //     context.push(AppRoutes.kEditProfileView);
            //   },
            // ),
            SizedBox(height: 5.h),

            SettingsInfoRow(
              prefexIcon: Icons.nightlight_outlined,
              text: 'Dark Mode',
              trailing: Switch(
                activeThumbColor: AppColors.kPrimaryColor,
                value: isDarkMode,
                onChanged: (val) {
                  // print(val);
                  setState(() {
                    isDarkMode = val;
                    if (isDarkMode) {
                      AppCubit.get(context).selectTheme(ThemeModeState.dark);
                    } else {
                      AppCubit.get(context).selectTheme(ThemeModeState.light);
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 5.h),
            SettingsInfoRow(
              prefexIcon: Icons.logout,
              text: 'Logout',
              trailing: null,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
