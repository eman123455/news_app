import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/Explore/data/model/comment_model.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
    required this.isExpanded,
    required this.onReply,
    required this.onToggleExpand,
  });

  final CommentModel comment;
  final bool isExpanded;
  final void Function(int id, String name) onReply;
  final void Function(int id) onToggleExpand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: comment.user?.image != null
                    ? NetworkImage(comment.user!.image!)
                    : const AssetImage('assets/images/png/splash_logo.png')
                          as ImageProvider,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.user?.name ?? 'Unknown',
                      style: TextStyle(fontWeight: Fonts.bold),
                    ),
                    SizedBox(height: 4.h),
                    Text(comment.content),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () =>
                          onReply(comment.id!, comment.user?.name ?? 'Unknown'),
                      child: Row(
                        children: [
                          Icon(Icons.reply, size: 16.r),
                          SizedBox(width: 4.w),
                          const Text('Reply'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (comment.replies.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 50.w, top: 6.h),
              child: GestureDetector(
                onTap: () => onToggleExpand(comment.id!),
                child: Text(
                  isExpanded
                      ? 'Hide replies'
                      : 'See replies (${comment.replies.length})',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),

          if (isExpanded)
            Padding(
              padding: EdgeInsets.only(left: 50.w, top: 8.h),
              child: Column(
                children: comment.replies.map((reply) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundImage: reply.user?.image != null
                              ? NetworkImage(reply.user!.image!)
                              : const AssetImage(
                                      'assets/images/png/splash_logo.png',
                                    )
                                    as ImageProvider,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reply.user?.name ?? 'Unknown',
                                style: TextStyle(fontWeight: Fonts.semiBold),
                              ),
                              Text(reply.content),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
