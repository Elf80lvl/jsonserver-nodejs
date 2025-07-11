part of 'home_page_bloc_bloc.dart';

sealed class HomePageBlocEvent extends Equatable {
  const HomePageBlocEvent();

  @override
  List<Object> get props => [];
}

final class HomePageLoadUsersEvent extends HomePageBlocEvent {}

final class HomePageDeleteUserEvent extends HomePageBlocEvent {
  final String userId;

  const HomePageDeleteUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

final class HomePageAddUserEvent extends HomePageBlocEvent {
  final Map<String, dynamic> user;

  const HomePageAddUserEvent(this.user);

  @override
  List<Object> get props => [user];
}
