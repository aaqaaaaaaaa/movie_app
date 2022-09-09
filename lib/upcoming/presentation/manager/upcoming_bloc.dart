import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';

import '../../data/data_sources/upcoming_remote.dart';
import '../../data/models/upcoming_movie.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  UpcomingBloc() : super(UpcomingInitial()) {
    on<GetUpcomingEvent>(getUpcomingMovie, transformer: sequential());
  }
  FutureOr<void> getUpcomingMovie(
      GetUpcomingEvent event, Emitter<UpcomingState> state) async {
    emit(UpcomingLoadingState());
    final result = await UpcomingRemote().getUpcomingMovie();
    if (result.isNotEmpty) {
      emit(UpcomingDataSuccessState(list: result));
    } else {
      emit(UpcomingNoDataState(message: 'Malumot yuklanishida hatolik'));
    }
  }
}
