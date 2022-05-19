import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var currentTurtle = 'wild';
Future navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Directionality(
      textDirection: TextDirection.rtl,
      child: widget,
    ),
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: widget,
        ),
      ),
          (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );


enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}



var currentUid;
var userName;
var adUnitBanner = 'ca-app-pub-5465142616619029/3222847644';