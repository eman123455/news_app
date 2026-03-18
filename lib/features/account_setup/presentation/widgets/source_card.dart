import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/features/account_setup/data/models/source_model.dart';

class SourceCard extends StatelessWidget {
  final SourceModel source;
  final bool isFollowing;
  final VoidCallback onToggle;

  const SourceCard({
    super.key,
    required this.source,
    required this.isFollowing,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo - Favicon or Initials
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderGrey),
          ),
          clipBehavior: Clip.antiAlias,
          child: Builder(
            builder: (context) {
              if (source.url.isEmpty) {
                return _buildPlaceholder();
              }
              
              try {
                final uri = Uri.parse(source.url);
                final domain = uri.host.isNotEmpty ? uri.host : source.url;
                final logoUrl = 'https://www.google.com/s2/favicons?domain=$domain&sz=128';
                
                return Image.network(
                  logoUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                );
              } catch (_) {
                return _buildPlaceholder();
              }
            },
          ),
        ),

        SizedBox(height: 6.h),

        // Source name
        Text(
          source.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),

        SizedBox(height: 6.h),

        // Follow / Following button
        GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isFollowing ? AppColors.primaryBlue : AppColors.white,
              border: Border.all(
                color: isFollowing
                    ? AppColors.primaryBlue
                    : AppColors.borderGrey,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              isFollowing ? 'Following' : 'Follow',
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: isFollowing ? AppColors.white : AppColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Text(
        source.name.isNotEmpty ? source.name[0].toUpperCase() : '?',
        style: GoogleFonts.poppins(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}
