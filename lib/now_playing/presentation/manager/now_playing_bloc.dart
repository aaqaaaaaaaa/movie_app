import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/now_playing/data/models/now_playing_movie.dart';

import '../../data/data_sources/now_playing_remote_datasource.dart';
//
// part 'now_playing_event.dart';

part 'now_playing_state.dart';

class NowPlayingBloc extends Cubit<NowPlayingState> {
  List<NowPlayingModel> modelList = [];

  NowPlayingBloc() : super(NowPlayingInitial()) {
    // on<GetNowPayingDataEvent>(getNews, transformer: sequential());
  }

  FutureOr<void> getNews() async {
    modelList.clear();
    emit(NowPlayingLoadingState());
    final result = await NowPlayingRemoteDatasource().getNowPlayingData();
    print(result);
    if (result.isNotEmpty) {
      emit(NowPlayingDataSuccessState(list: result));
    } else {
      emit(NowPlayingNoDataState(message: 'Malumotlarda hatolik'));
    }
  }
}
