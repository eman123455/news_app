import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/components/custom_circular_progress_indicator.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.userFristLetter = 'U',
    this.height,
    this.width, this.fontSize,
  });
  final String imageUrl;
  final BoxFit? fit;
  final String? userFristLetter;
  final double? height;
  final double? width;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) => CustomCircularProgressIndicator(),
      errorWidget: (context, url, error) => Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '$userFristLetter',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
