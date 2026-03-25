import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String label;
  final String iconPath; // Use IconData or Image.asset
  const SocialMediaButton({
    super.key,
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F4F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 20, height: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
