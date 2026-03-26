import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final double height;
  final Color color;
  final String buttonName;
    final bool? disable;
  final void Function() onPressend;

  const CustomeButton({
    super.key,
    required this.height,
    required this.color,
    required this.onPressend,
    required this.buttonName,
    this.disable,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressend,
        child:  Text(
          buttonName,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
