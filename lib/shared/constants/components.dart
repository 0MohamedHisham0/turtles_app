import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turtles_app/modules/chat_screen/chat_screen.dart';
import 'package:turtles_app/shared/constants/constants.dart';

import '../../styles/colors.dart';
import '../cubit/cubit.dart';

Widget myDivider() => Container(
      width: double.infinity,
      height: 0.3,
      color: Colors.grey,
    );

Widget postItem(String question, String commentsNum) {
  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: () {},
    child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.question_answer,
                      color: defaultColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(question,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              myDivider(),
              Row(
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20)),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/like.svg',
                              width: 20, color: defaultColor),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text('مفيد',
                              style:
                                  TextStyle(fontSize: 19, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all( 10.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/dislike.svg',
                              width: 20, color: Colors.red),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text('غير مفيد',
                              style:
                                  TextStyle(fontSize: 19, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20)),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: defaultColor,
                              size: 19,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(commentsNum + ' تعليق',
                                style: const TextStyle(
                                    fontSize: 19, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.4),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        )),
  );
}

Widget turtleListScreen(context, List<String> imagesUrl) {
  return Scaffold(
    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            if (imagesUrl.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  aspectRatio: 16 / 9,
                ),
                items: imagesUrl.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: defaultColor,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                    )
                                  ],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  color: Colors.red,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image(
                                    fit: BoxFit.cover, image: NetworkImage(i))),
                            Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.grey.withOpacity(0.0),
                                          Colors.grey
                                        ],
                                        stops: const [
                                          0.0,
                                          0.7
                                        ])),
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 11.0),
                                  child: Text(
                                    'اسال اي سؤال عن السلاحف وستجد الاجابه فورا',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                navigateTo(context, const ChatScreen());
              },
              child: Container(
                  width: double.infinity,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text("ما هو سؤالك  ؟",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: defaultColor, width: 2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return postItem("ماذا تاكل السلاحف ؟", '23');
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: 20)
          ],
        ),
      ),
    ),
  );
}
