import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/Explore/data/repo/explore_repo_implementation.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._repository) : super(ExploreInitial());
  final ExploreRepositoryImpl _repository;
  Future<void> getExplores() async {
    emit(ExploreLoading());
    try {
      final explores = await _repository.getExplores();
      emit(ExploreLoaded(explores));
    } catch (e) {
      emit(ExploreError(e.toString()));
    }
  }
}
