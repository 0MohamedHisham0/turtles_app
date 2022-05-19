import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turtles_app/shared/constants/constants.dart';
import 'package:turtles_app/shared/cubit/cubit.dart';
import 'package:turtles_app/shared/cubit/states.dart';
import 'package:turtles_app/shared/network/local/CachHelper.dart';
import 'package:turtles_app/styles/colors.dart';
import 'layouts/home_layout/home_layout_screen.dart';
import 'modules/login/login_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String version;
  List<String> testDeviceIds = ['55E8BFD920137E91DE25B9523135D5F9'];

  // thing to add
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);

  await Firebase.initializeApp();
  await CacheHelper.init();
  MobileAds.instance.initialize();

  Widget? widget;
  currentUid = CacheHelper.getData(key: 'currentUid');

  if (currentUid == null) {
    widget = const LoginScreen();
  } else {
    widget = const HomeLayoutScreen();
  }

  runApp(
    MyApp(widget: widget),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.widget}) : super(key: key);
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => TurtlesAppCubit()
                ..getSeaPosts()
                ..getWildPosts()
                ..loadAndListenToAd()
                ..getSeaTurtlesImages()
                ..getWildTurtlesImages()),
        ],
        child: BlocConsumer<TurtlesAppCubit, TurtlesAppStates>(
          listener: (context, state) {},
          builder: (context, states) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: defaultColor, fontFamily: 'Harmattan'),
              home: Directionality(
                  textDirection: TextDirection.rtl,
                  child: widget ?? const LoginScreen()),
            );
          },
        ));
  }
}
