import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:turtles_app/modules/chat/cubit/states.dart';

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

        return ConditionalBuilder(
          condition: state is TurtlesAppGetLoadingSuccessState,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          fallback: (context) => turtleListScreen(context, cubit.seaImagesUrl, cubit.postsSea),
        );

      },
    );
  }
}
