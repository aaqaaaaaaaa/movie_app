import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/home/bloc/home_bloc.dart';
import 'package:movie_app/home/pages/home_page.dart';
import 'package:movie_app/movie_details/presentation/manager/movie_details_bloc.dart';
import 'package:movie_app/now_playing/presentation/manager/now_playing_bloc.dart';
import 'package:movie_app/popular/presentation/manager/popular_bloc.dart';
import 'package:movie_app/upcoming/presentation/manager/upcoming_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => NowPlayingBloc(),
        ),
        BlocProvider(
          create: (context) => PopularBloc(),
        ),
        BlocProvider(
          create: (context) => UpcomingBloc(),
        ),
      ], child: const HomePage()),
    );
  }
}
