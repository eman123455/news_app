import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/Explore/data/repo/explore_repo_implementation.dart';

part 'explore_state.dart';

// class ExploreCubit extends Cubit<ExploreState> {
//   ExploreCubit(this._repository) : super(ExploreInitial());
//   final ExploreRepositoryImpl _repository;
//   List<ExploreModel>? allExploresNews;
//   List<ExploreModel>? followingsExplores;
//   List<dynamic>? followingsUsersList;
//
//   Future<void> getExplores() async {
//     emit(ExploreLoading());
//     try {
//       allExploresNews = await _repository.getAllExploresNews();
//       followingsUsersList = await _repository.getFollowingsUsersList();
//       followingsExplores = await _repository.getFollowingsExplores(
//         followingsUsersList!,
//       );
//       print('followingsUsersList: ${followingsExplores?[0].userId}');
//       print('followingsExplores: ${followingsExplores?[1].userId}');
//
//       emit(
//         ExploreLoaded(
//           explores: allExploresNews!,
//           followingExplores: followingsExplores!,
//         ),
//       );
//     } catch (e) {
//       emit(ExploreError(e.toString()));
//     }
//   }
// }
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._repository) : super(ExploreInitial());
  final ExploreRepositoryImpl _repository;

  Future<void> getExplores() async {
    emit(ExploreLoading());
    try {
      final allExploresNews = await _repository.getAllExploresNews();
      final followingsUsersList = await _repository.getFollowingsUsersList();
      final followingsExplores = followingsUsersList.isEmpty
          ? <ExploreModel>[]
          : await _repository.getFollowingsExplores(followingsUsersList);

      emit(ExploreLoaded(
        explores: allExploresNews,
        followingExplores: followingsExplores,
      ));
    } catch (e) {
      emit(ExploreError(e.toString()));
    }
  }
  Future<void> refresh() => getExplores();

  void changeTab(int index) {
    final currentState = state;
    if (currentState is ExploreLoaded) {
      emit(currentState.copyWith(selectedTab: index));
    }
  }
}