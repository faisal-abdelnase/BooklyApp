import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repos/home_repo.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.homeRepo) : super(NewestBooksInitial());

  final HomeRepo homeRepo;

  Future<void> fetchNewsetBooks() async {
    emit(NewestBookLoading());
    var result = await homeRepo.fetchNewsetBooks();

    result.fold((failure) {
      emit(NewestBooksFailuer(failure.errMessage));
    }, (books) {
      emit(NewestBooksSuccess(books));
    });
  }
}
