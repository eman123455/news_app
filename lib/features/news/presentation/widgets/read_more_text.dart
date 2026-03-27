import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_fonts.dart';

class ReadMoreText extends StatefulWidget {
  final String text;

  const ReadMoreText({super.key, required this.text});

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 24.sp,
      fontWeight: Fonts.semiBold,
      color: Colors.black,
    );

    final linkStyle = TextStyle(
      color: Colors.grey[600],
      fontSize: 22.sp,
      fontWeight: FontWeight.w500,
    );

    return LayoutBuilder(
      builder: (context, size) {
        final maxWidth = size.maxWidth;

        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: textStyle),
          maxLines: 2,
          textDirection: Directionality.of(context),
        )..layout(maxWidth: maxWidth);

        if (!textPainter.didExceedMaxLines) {
          return Text(widget.text, style: textStyle);
        }

        if (isExpanded) {
          return RichText(
            text: TextSpan(
              style: textStyle,
              children: [
                TextSpan(text: widget.text),
                TextSpan(
                  text: " See less",
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() => isExpanded = false);
                    },
                ),
              ],
            ),
          );
        }

        const linkText = " ... See more";

        int endIndex = widget.text.length;

        for (int i = widget.text.length; i > 0; i--) {
          final testText = widget.text.substring(0, i);

          final tp = TextPainter(
            text: TextSpan(
              children: [
                TextSpan(text: testText, style: textStyle),
                TextSpan(text: linkText, style: linkStyle),
              ],
            ),
            maxLines: 2,
            textDirection: Directionality.of(context),
          )..layout(maxWidth: maxWidth);

          if (!tp.didExceedMaxLines) {
            endIndex = i;
            break;
          }
        }

        final visibleText = widget.text.substring(0, endIndex);

        return RichText(
          text: TextSpan(
            style: textStyle,
            children: [
              TextSpan(text: visibleText),
              TextSpan(
                text: linkText,
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() => isExpanded = true);
                  },
              ),
            ],
          ),
        );
      },
    );
  }
}