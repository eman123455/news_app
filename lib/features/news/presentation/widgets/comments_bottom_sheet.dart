import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/Explore/data/model/comment_model.dart';
import 'package:news_app/features/news/bloc/post_details_cubit.dart';

class CommentsSheet extends StatefulWidget {
  const CommentsSheet({
    super.key,
    required this.postId,
  });

  final int postId;

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final TextEditingController _controller = TextEditingController();
  final DraggableScrollableController _sheetController =
  DraggableScrollableController();

  @override
  void dispose() {
    _controller.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final state = context.read<PostDetailsCubit>().state;
    if (state is! PostDetailsLoaded) return;

    if (state.replyingToCommentId != null) {
      context.read<PostDetailsCubit>().addReply(
        parentCommentId: state.replyingToCommentId!,
        content: text,
      );
    } else {
      context.read<PostDetailsCubit>().addComment(text);
    }

    _controller.clear();
    context.read<PostDetailsCubit>().clearReply();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(
      builder: (context, state) {
        if (state is! PostDetailsLoaded) return const SizedBox();

        return DraggableScrollableSheet(
          expand: false,
          shouldCloseOnMinExtent: false,
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          controller: _sheetController,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                children: [
                  // ── Handle ─────────────────────────────
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    width: 40.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),

                  Text(
                    'Comments',
                    style: TextStyle(fontSize: 18.sp, fontWeight: Fonts.bold),
                  ),

                  const Divider(),

                  // ── Comments List ───────────────────────
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: state.comments.length,
                      separatorBuilder: (_, __) =>
                          Divider(indent: 12.w, endIndent: 12.w),
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return _CommentItem(
                          comment: comment,
                          isExpanded: state.expandedComments
                              .contains(comment.id),
                          onReply: (id, name) =>
                              context.read<PostDetailsCubit>().setReply(id, name),
                          onToggleExpand: (id) => context
                              .read<PostDetailsCubit>()
                              .toggleExpandComment(id),
                        );
                      },
                    ),
                  ),

                  // ── Reply Indicator ─────────────────────
                  if (state.replyingToName != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 6.h),
                      color: Colors.grey[100],
                      child: Row(
                        children: [
                          Text(
                            'Replying to ${state.replyingToName}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () =>
                                context.read<PostDetailsCubit>().clearReply(),
                            child: const Icon(Icons.close,
                                size: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                  // ── Input ───────────────────────────────
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      bottom:
                      MediaQuery.of(context).viewInsets.bottom + 16.h,
                      top: 16.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48.h,
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: state.replyingToName != null
                                    ? 'Reply to ${state.replyingToName}...'
                                    : 'Type your comment...',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: _send,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ── Comment Item ─────────────────────────────────────────────
class _CommentItem extends StatelessWidget {
  const _CommentItem({
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
          // ── Main Comment ──────────────────────────────
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
                      onTap: () => onReply(
                        comment.id!,
                        comment.user?.name ?? 'Unknown',
                      ),
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

          // ── Toggle Replies ────────────────────────────
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

          // ── Replies ───────────────────────────────────
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
                              'assets/images/png/splash_logo.png')
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