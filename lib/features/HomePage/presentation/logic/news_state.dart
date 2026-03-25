
import 'package:equatable/equatable.dart';
import '../../Domain/Entity/article_entity.dart';
abstract class NewsState extends Equatable {
  List<Object?> get props => [];
}
class InitialState extends NewsState {}
class LoadingState extends NewsState {}
class SuccessState extends NewsState {
  final List<ArticleEntity> articles;
  SuccessState(this.articles);
}
class ErrorState extends NewsState {
  final String message;
  ErrorState(this.message);
}

