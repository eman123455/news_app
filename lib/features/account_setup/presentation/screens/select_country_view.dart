import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/account_setup/business_logic/cubit/account_setup_cubit.dart';
import 'package:news_app/features/account_setup/data/models/country_model.dart';
import 'package:news_app/features/account_setup/presentation/widgets/country_list_tile.dart';

class SelectCountryView extends StatefulWidget {
  const SelectCountryView({super.key});

  @override
  State<SelectCountryView> createState() => _SelectCountryViewState();
}

class _SelectCountryViewState extends State<SelectCountryView> {
  final TextEditingController _searchController = TextEditingController();
  List<CountryModel> _filtered = CountryModel.all;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = CountryModel.all
          .where((c) => c.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          'Select your Country',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
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
                  prefixIcon: Icon(Icons.search, color: AppColors.textGrey, size: 20.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),

          // ── Country list ──
          Expanded(
            child: BlocBuilder<AccountSetupCubit, AccountSetupState>(
              builder: (context, state) {
                final cubit = context.read<AccountSetupCubit>();
                return ListView.builder(
                  itemCount: _filtered.length,
                  itemBuilder: (context, index) {
                    final country = _filtered[index];
                    final isSelected =
                        cubit.selectedCountry?.code == country.code;
                    return CountryListTile(
                      country: country,
                      isSelected: isSelected,
                      onTap: () => cubit.selectCountry(country),
                    );
                  },
                );
              },
            ),
          ),

          // ── Next button ──
          BlocBuilder<AccountSetupCubit, AccountSetupState>(
            builder: (context, state) {
              final cubit = context.read<AccountSetupCubit>();
              final hasSelection = cubit.selectedCountry != null;
              return Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed:
                        hasSelection ? () => context.push(AppRoutes.kChooseTopics) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      disabledBackgroundColor: AppColors.borderGrey,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
