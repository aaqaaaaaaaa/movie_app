part of 'now_playing_bloc.dart';

@immutable
abstract class NowPlayingState {}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoadingState extends NowPlayingState {}

class NowPlayingNoInternetState extends NowPlayingState {}

class NowPlayingNoDataState extends NowPlayingState {
  final String message;

  NowPlayingNoDataState({required this.message});
}

class NowPlayingDataSuccessState extends NowPlayingState {
  final List<NowPlayingModel> list;

  NowPlayingDataSuccessState({required this.list});
}
