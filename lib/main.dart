import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turtles_app/shared/cubit/cubit.dart';
import 'package:turtles_app/shared/cubit/states.dart';
import 'package:turtles_app/styles/colors.dart';
import 'layouts/home_layout/home_layout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TurtlesAppCubit()),
        ],
        child: BlocConsumer<TurtlesAppCubit, TurtlesAppStates>(
          listener: (context, state) {},
          builder: (context, states) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: defaultColor, fontFamily: 'Harmattan'),
              home: const Directionality(
                  textDirection: TextDirection.rtl, child: HomeLayoutScreen()),
            );
          },
        ));
  }
}
