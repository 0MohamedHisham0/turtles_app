import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turtles_app/shared/constants/components.dart';
import 'package:turtles_app/shared/cubit/cubit.dart';
import 'package:turtles_app/shared/cubit/states.dart';

class WildTurtlesScreen extends StatelessWidget {
  const WildTurtlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TurtlesAppCubit, TurtlesAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TurtlesAppCubit.get(context);
        return turtleListScreen(context, cubit.wildImagesUrl);
      },
    );
  }
}
