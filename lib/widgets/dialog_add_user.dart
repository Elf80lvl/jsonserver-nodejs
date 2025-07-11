import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonserver/const.dart';
import 'package:jsonserver/pages/home_page/bloc/home_page_bloc_bloc.dart';
import 'package:uuid/uuid.dart';

class DialogAddUser extends StatefulWidget {
  const DialogAddUser({super.key});

  @override
  State<DialogAddUser> createState() => _DialogAddUserState();
}

class _DialogAddUserState extends State<DialogAddUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(kDialogAddUserWidth / 2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kDialogAddUserWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  final name = _nameController.text;
                  final email = _emailController.text;
                  if (name.isEmpty || email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                  } else {
                    final uuid = Uuid();
                    final user = {
                      'id': uuid.v4(),
                      'name': name,
                      'email': email,
                    };
                    context.read<HomePageBlocBloc>().add(
                      HomePageAddUserEvent(user),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
