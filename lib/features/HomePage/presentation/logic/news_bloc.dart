import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/HomePage/Domain/UsesCase/use_case_news.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final UseCaseNews _useCaseNews;

  NewsBloc(this._useCaseNews) : super(InitialState()){
    on<FetchNews> ((event, emit) async {
      emit(LoadingState() );
      try {
        final news = await _useCaseNews.call(category: event.category);
        emit(SuccessState(news) );
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }

}
