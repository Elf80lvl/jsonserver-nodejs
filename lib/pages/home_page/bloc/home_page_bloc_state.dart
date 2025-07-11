part of 'home_page_bloc_bloc.dart';

sealed class HomePageBlocState extends Equatable {
  const HomePageBlocState();

  @override
  List<Object> get props => [];
}

final class HomePageBlocInitial extends HomePageBlocState {}

final class HomePageLoadingState extends HomePageBlocState {}

final class HomePageLoadedState extends HomePageBlocState {
  final List<dynamic> users;

  const HomePageLoadedState(this.users);

  @override
  List<Object> get props => [users];
}
