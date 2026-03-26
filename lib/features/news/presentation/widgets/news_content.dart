import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsContentInput extends StatefulWidget {
  final int maxLength;
  final TextEditingController? controller;

  const NewsContentInput({super.key, this.maxLength = 2000, this.controller});

  @override
  State<NewsContentInput> createState() => _NewsContentInput();
}

class _NewsContentInput extends State<NewsContentInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 120.h, maxHeight: 300.h),
      child: TextField(
        controller: _controller,
        maxLines: null,
        minLines: 7,
        maxLength: widget.maxLength,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 12.w,
          ),
          hintText: 'Write full news content here...',
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          alignLabelWithHint: true,
          counterText: '${_controller.text.length}/${widget.maxLength}',
        ),
      ),
    );
  }
}
