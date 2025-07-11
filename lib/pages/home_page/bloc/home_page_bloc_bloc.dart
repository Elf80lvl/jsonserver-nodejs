import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jsonserver/services/api_server.dart';

part 'home_page_bloc_event.dart';
part 'home_page_bloc_state.dart';

class HomePageBlocBloc extends Bloc<HomePageBlocEvent, HomePageBlocState> {
  HomePageBlocBloc() : super(HomePageBlocInitial()) {
    on<HomePageLoadUsersEvent>((event, emit) async {
      emit(HomePageLoadingState());
      try {
        final users = await ApiServer.fetchUsers(); // Always fetch from server
        emit(HomePageLoadedState(users));
      } catch (e) {
        // emit(HomePageBlocInitial());
        throw Exception('Failed to load users: $e');
      }
    });

    on<HomePageDeleteUserEvent>((event, emit) async {
      await ApiServer.deleteUser(event.userId);
      add(HomePageLoadUsersEvent()); // повторная загрузка после удаления
    });

    on<HomePageAddUserEvent>((event, emit) async {
      await ApiServer.addUser(event.user);
      add(HomePageLoadUsersEvent()); // повторная загрузка после добавления
    });
  }
}
