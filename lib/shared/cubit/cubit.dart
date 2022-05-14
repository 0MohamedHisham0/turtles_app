import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turtles_app/styles/colors.dart';

import '../../modules/wild_turtles/wild_turtles_screen.dart';
import '../../modules/sea_turtles/sea_turtles_screen.dart';
import '../../shared/cubit/states.dart';

class TurtlesAppCubit extends Cubit<TurtlesAppStates> {
  TurtlesAppCubit() : super(TurtlesAppInitialState());

  static TurtlesAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = ['البرية', 'البحرية'];

  List<Widget> pages = [
    WildTurtlesScreen(),
    SeaTurtlesScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      defaultColor = defaultColorWild;
    } else {
      defaultColor = defaultColorSea;
    }

    emit(TurtlesAppIndexChanged());
  }
}
