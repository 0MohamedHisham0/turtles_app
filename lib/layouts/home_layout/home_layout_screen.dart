import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:turtles_app/styles/colors.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TurtlesAppCubit.get(context);

    return BlocConsumer<TurtlesAppCubit, TurtlesAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Builder(
          builder: (context) {
            return Scaffold(
                appBar: AppBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  title: Center(child: Text(cubit.titles[cubit.currentIndex])),

                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                          'assets/images/svg_wild_turtle.svg',
                          width: 30, height: 26,
                          color: defaultColor),
                      label: 'السلاحف البرية',
                      icon: SvgPicture.asset('assets/images/svg_wild_turtle.svg',
                          width: 25, height: 24,color: Colors.grey),
                    ),
                    BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        'assets/images/svg_sea_turtle.svg',
                        width: 30,
                        color: defaultColor,
                      ),
                      icon: SvgPicture.asset(
                        'assets/images/svg_sea_turtle.svg',
                        width: 25,
                        color: Colors.grey,
                      ),

                      label: 'السلاحف البحرية',
                    ),
                  ],
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeIndex(index);
                  },
                ),
                body: Column(
                  children: [
                    Expanded(child: cubit.pages[cubit.currentIndex]),
                    Container(
                        alignment: Alignment.center,
                        width: cubit.myBanner.size.width.toDouble(),
                        height: cubit.myBanner.size.height.toDouble(),
                        child: AdWidget(ad: cubit.myBanner)),
                  ],
                ));
          }
        );
      },
    );
  }
}
