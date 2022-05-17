import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turtles_app/shared/cubit/cubit.dart';
import 'package:turtles_app/shared/cubit/states.dart';
import 'package:turtles_app/styles/colors.dart';
import 'layouts/home_layout/home_layout_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TurtlesAppCubit()..getSeaTurtlesImages()..getWildTurtlesImages()),
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
