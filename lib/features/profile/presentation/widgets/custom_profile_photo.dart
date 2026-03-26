import 'package:flutter/cupertino.dart';
import 'package:news_app/core/components/cache_image.dart';

class CustomProfilePhoto extends StatelessWidget {
  const CustomProfilePhoto({
    super.key,
    required this.imageUrl,
    this.userName,
    this.width,
    this.height,
    this.fontsize,
  });
  final String imageUrl;
  final String? userName;
  final double? width;
  final double? height;
  final double? fontsize;
  String getFirstLetter(String? name) {
    if (name == null || name.isEmpty) return 'U';
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CacheImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fontSize: fontsize,
        userFristLetter: getFirstLetter(userName),
      ),
    );
  }
}
