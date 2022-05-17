import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SeaTurtlesScreen extends StatelessWidget {
  const SeaTurtlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TurtlesAppCubit, TurtlesAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TurtlesAppCubit.get(context);
        cubit.getPosts();
        return turtleListScreen(context, cubit.seaImagesUrl, cubit.postsSea);
      },
    );
  }
}
