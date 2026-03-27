import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_colors.dart';

class PublishButton extends StatelessWidget {
  const PublishButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: AppColors.kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: const Text(
                'Publish News',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.send, color: Colors.white, size: 24),
                SizedBox(height: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
