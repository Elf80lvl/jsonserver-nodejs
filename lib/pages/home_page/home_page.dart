import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonserver/pages/home_page/bloc/home_page_bloc_bloc.dart';
import 'package:jsonserver/widgets/dialog_add_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddUserDialog(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                context.read<HomePageBlocBloc>().add(HomePageLoadUsersEvent());
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomePageBlocBloc, HomePageBlocState>(
        builder: (context, state) {
          if (state is HomePageLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomePageLoadedState) {
            final users = state.users;
            return Column(
              children: List.generate(users.length, (index) {
                return ListTile(
                  title: Text(users[index]['name'] ?? 'No Name'),
                  subtitle: Text(users[index]['email'] ?? 'No Email'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<HomePageBlocBloc>().add(
                        HomePageDeleteUserEvent(users[index]['id']),
                      );
                      // context.read<HomePageBlocBloc>().add(
                      //   HomePageLoadUsersEvent(),
                      // );
                    },
                  ),
                );
              }),
            );
          }
          return Center(child: Text('error'));
        },
      ),
    );
  }

  void showAddUserDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => DialogAddUser());
  }
}
