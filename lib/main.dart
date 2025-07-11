import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonserver/pages/home_page/bloc/home_page_bloc_bloc.dart';
import 'package:jsonserver/pages/home_page/home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => HomePageBlocBloc()..add(HomePageLoadUsersEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Server',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}
