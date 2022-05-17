import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turtles_app/shared/constants/constants.dart';
import 'package:turtles_app/styles/colors.dart';

import '../../modules/wild_turtles/wild_turtles_screen.dart';
import '../../modules/sea_turtles/sea_turtles_screen.dart';
import '../../shared/cubit/states.dart';

class TurtlesAppCubit extends Cubit<TurtlesAppStates> {
  TurtlesAppCubit() : super(TurtlesAppInitialState());

  static TurtlesAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = ['السلاحف البرية', 'السلاحف البحرية'];

  List<Widget> pages = [
    const WildTurtlesScreen(),
    const SeaTurtlesScreen(),
  ];

  List<String> seaImagesUrl = [];
  List<String> wildImagesUrl = [];

  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      currentTurtle = 'wild';
      defaultColor = defaultColorWild;
    } else {
      currentTurtle = 'sea';
      defaultColor = defaultColorSea;
    }

    emit(TurtlesAppIndexChanged());
  }

  void getWildTurtlesImages() {
    wildImagesUrl = [];
    FirebaseFirestore.instance
        .collection("TurtlesImages")
        .doc("Wild")
        .get()
        .then((value) {

      emit(TurtlesAppGetTurtlesImagesSuccessState());

      value.data()!.forEach((key, value) {
        wildImagesUrl.add(value);
      });
    }).catchError((error) {
      emit(TurtlesAppGetTurtlesImagesErrorState());
      print(error);
    });
  }

  void getSeaTurtlesImages() {
    seaImagesUrl = [];
    FirebaseFirestore.instance
        .collection("TurtlesImages")
        .doc("Sea")
        .get()
        .then((value) {
      print("==========================");
      emit(TurtlesAppGetTurtlesImagesSuccessState());

      value.data()!.forEach((key, value) {
        seaImagesUrl.add(value);
      });
    }).catchError((error) {
      emit(TurtlesAppGetTurtlesImagesErrorState());
      print(error);
    });
  }

}
