import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'book_mark_state.dart';

class BookMarkCubit extends Cubit<BookMarkState> {
  BookMarkCubit() : super(BookMarkInitial());
}
