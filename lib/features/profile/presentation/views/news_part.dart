import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/components/custom_circular_progress_indicator.dart';
import 'package:news_app/features/profile/data/models/profile_model.dart';
import 'package:news_app/features/profile/presentation/widgets/custom_news_card.dart';
import 'package:news_app/features/profile/profile_business_logic/posts_cubit/posts_cubit.dart';

class NewsPart extends StatelessWidget {
  const NewsPart({super.key, required this.user});
  final ProfileModel user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is GetPostsLoading || state is PostsInitial) {
          return CustomCircularProgressIndicator();
        } else if (state is GetPostsSuccess) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return CustomNewsCard(postModel: post, user: user);
            },
          );
        } else if (state is GetPostsFailed) {
          return Text(state.errMsg);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
