import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final ImagePicker _picker = ImagePicker();
Future<File?> pickImageFromDevice() async {
  try {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return null;
    return File(picked.path);
  } catch (_) {
    return null;
  }
}

Future<String?> uploadImageToStorage(File image) async {
  try {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final path = 'profiles/$fileName';
    const bucketName = 'images';
    print('Uploading to bucket: $bucketName, path: $path');
    await AppConstants.supabase.storage
        .from(bucketName)
        .upload(
          path,
          image,
          fileOptions: FileOptions(
            upsert: true, // replace if same path
          ),
        );
    // get link
    final imageUrl = AppConstants.supabase.storage
        .from(bucketName)
        .getPublicUrl(path);

    return imageUrl;
  } catch (e) {
    print('Upload error: $e');
    return null;
  }
}
