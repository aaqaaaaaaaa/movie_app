part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsNoInternetState extends MovieDetailsState {}

class MovieDetailsNoDataState extends MovieDetailsState {
  final String message;

  MovieDetailsNoDataState({required this.message});
}

class MovieDetailsDataSuccessState extends MovieDetailsState {
  final MovieDetailsModel list;

  MovieDetailsDataSuccessState({required this.list});
}
