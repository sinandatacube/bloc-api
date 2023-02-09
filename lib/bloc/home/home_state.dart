part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String error;
  HomeError({required this.error});
}

class DataLoaded extends HomeState {
  var data;
  DataLoaded({required this.data});
}
