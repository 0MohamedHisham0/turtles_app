import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:turtles_app/shared/constants/components.dart';

import 'package:turtles_app/shared/cubit/cubit.dart';
import 'package:turtles_app/shared/cubit/states.dart';
import 'package:turtles_app/styles/colors.dart';

class WildTurtlesScreen extends StatelessWidget {
  const WildTurtlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TurtlesAppCubit, TurtlesAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return turtleListScreen();
      },
    );
  }


}
