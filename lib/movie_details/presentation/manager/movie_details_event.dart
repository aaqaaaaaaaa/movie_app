part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsEvent {}

class GetMovieDetailsDataEvent extends MovieDetailsEvent {
  final int id;

  GetMovieDetailsDataEvent({required this.id});
}
