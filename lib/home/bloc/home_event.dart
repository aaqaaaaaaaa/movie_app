part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeChangeEvent extends HomeEvent {
  final int index;

  HomeChangeEvent(this.index);
}
