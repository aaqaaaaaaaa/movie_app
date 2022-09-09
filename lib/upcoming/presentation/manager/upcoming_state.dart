part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingState {}

class UpcomingInitial extends UpcomingState {}

class UpcomingLoadingState extends UpcomingState {}

class UpcomingNoInternetState extends UpcomingState {}

class UpcomingNoDataState extends UpcomingState {
  final String message;

  UpcomingNoDataState({required this.message});
}

class UpcomingDataSuccessState extends UpcomingState {
  final List<UpcomingModel> list;

  UpcomingDataSuccessState({required this.list});
}
