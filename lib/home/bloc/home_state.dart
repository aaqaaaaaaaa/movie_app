part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeIndexState extends HomeState {
  final int index;

  ChangeIndexState({required this.index});
}
