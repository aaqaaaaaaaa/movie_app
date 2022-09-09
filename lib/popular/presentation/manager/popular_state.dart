part of 'popular_bloc.dart';

@immutable
abstract class PopularState {}

class PopularInitial extends PopularState {}

class PopularLoadingState extends PopularState {}

class PopularNoInternetState extends PopularState {}

class PopularNoDataState extends PopularState {
  final String message;

  PopularNoDataState({required this.message});
}

class PopularDataSuccessState extends PopularState {
  final List<PopularModel> list;

  PopularDataSuccessState({required this.list});
}
