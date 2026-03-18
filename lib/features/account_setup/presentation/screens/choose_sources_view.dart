import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/account_setup/business_logic/cubit/account_setup_cubit.dart';
import 'package:news_app/features/account_setup/data/models/source_model.dart';
import 'package:news_app/features/account_setup/presentation/widgets/source_card.dart';

class ChooseSourcesView extends StatefulWidget {
  const ChooseSourcesView({super.key});

  @override
  State<ChooseSourcesView> createState() => _ChooseSourcesViewState();
}

class _ChooseSourcesViewState extends State<ChooseSourcesView> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SourceModel> _applyFilter(List<SourceModel> sources) {
    if (_query.isEmpty) return sources;
    return sources
        .where((s) => s.name.toLowerCase().contains(_query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColors.black),
        ),
        title: Text(
          'Choose your News Sources',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AccountSetupCubit, AccountSetupState>(
        builder: (context, state) {
          final cubit = context.read<AccountSetupCubit>();

          // ── Loading ──
          if (state is AccountSetupLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            );
          }

          // ── Error ──
          if (state is AccountSetupError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi_off_rounded,
                        size: 48.sp, color: AppColors.textGrey),
                    SizedBox(height: 12.h),
                    Text(
                      'Failed to load sources.\nCheck your connection.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () => cubit.fetchSources(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        'Retry',
                        style: GoogleFonts.poppins(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // ── Sources loaded (or selection updated) ──
          final sources = _applyFilter(cubit.sources);

          return Column(
            children: [
              // ── Search bar ──
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: AppColors.textGrey,
                      ),
                      prefixIcon:
                          Icon(Icons.search, color: AppColors.textGrey, size: 20.sp),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ),

              // ── Grid ──
              Expanded(
                child: sources.isEmpty
                    ? Center(
                        child: Text(
                          'No sources found.',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: AppColors.textGrey,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20.h,
                          crossAxisSpacing: 12.w,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: sources.length,
                        itemBuilder: (context, index) {
                          final source = sources[index];
                          return SourceCard(
                            source: source,
                            isFollowing:
                                cubit.followedSources.contains(source.id),
                            onToggle: () => cubit.toggleSource(source.id),
                          );
                        },
                      ),
              ),

              // ── Next button ──
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () => context.push(AppRoutes.kFillProfile),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
