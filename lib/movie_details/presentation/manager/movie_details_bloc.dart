import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/movie_details/data/models/movie_details_model.dart';

import '../../data/data_sources/movie_details_remote.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial()) {
    on<GetMovieDetailsDataEvent>(getMovieDetails, transformer: sequential());
  }

  FutureOr<void> getMovieDetails(
      GetMovieDetailsDataEvent event, Emitter<MovieDetailsState> emit) async {
    print(state);
    emit(MovieDetailsLoadingState());
    final result =
        await MovieDetailsRemoteDatasource().getMovieDetailsData(event.id);
    print(result);
    if (result != null) {
      emit(MovieDetailsDataSuccessState(list: result));
    } else {
      emit(MovieDetailsNoDataState(message: 'Malumotlarda hatolik'));
    }
  }
}
