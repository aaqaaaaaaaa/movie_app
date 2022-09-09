import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/popular/data/data_sources/popular_remote.dart';
import 'package:movie_app/popular/data/models/popular_model.dart';

part 'popular_event.dart';

part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc() : super(PopularInitial()) {
    on<GetPopularMovies>(getPopularMovie, transformer: sequential());
  }

  FutureOr<void> getPopularMovie(
      GetPopularMovies event, Emitter<PopularState> state) async {
    emit(PopularLoadingState());
    final result = await PopularRemote().getPopularMovie();
    if (result.isNotEmpty) {
      emit(PopularDataSuccessState(list: result));
    } else {
      emit(PopularNoDataState(message: 'Malumot yuklanishida hatolik'));
    }
  }
}
