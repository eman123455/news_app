import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CoverPhotoWidget extends StatelessWidget {
  final String? imageUrl;
  const CoverPhotoWidget({super.key, this.imageUrl, this.selectedImage});
  final File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(12),
        dashPattern: const [6, 4],
        color: Colors.grey,
        strokeWidth: 1.5,
      ),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: selectedImage != null
            ? Image.file(selectedImage!, fit: BoxFit.cover)
            : (imageUrl != null && imageUrl!.isNotEmpty)
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  alignment: Alignment.center,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.broken_image, color: Colors.black54),
                  ),
                ),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 28, color: Colors.black54),
                  SizedBox(height: 8),
                  Text(
                    "Add Cover Photo",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
      ),
    );
  }
}
