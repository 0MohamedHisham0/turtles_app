import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/colors.dart';

Widget myDivider() => Container(
      width: double.infinity,
      height: 0.3,
      color: Colors.grey,
    );

Widget questionItem() {
  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: () {},
    child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 14.0, right: 12.0, left: 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.question_answer,
                    color: defaultColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(" ماذا تاكل السلاحف ؟",
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.black)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              myDivider(),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                      padding: const EdgeInsets.all(8.0),
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
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: defaultColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const Text('التعليقات',
                                style: TextStyle(
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

Widget turtleListScreen() {
  return Scaffold(
    body: SingleChildScrollView(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  aspectRatio: 16 / 9,
                ),
                items: [
                  'https://i.pinimg.com/564x/57/91/63/579163f64da6acbbc762bcdd6e28d97a.jpg',
                  'https://i.pinimg.com/564x/c2/63/e8/c263e8772c267c8d215a75c0cd3eb4ad.jpg',
                  'https://i.pinimg.com/564x/2c/0e/00/2c0e0095fdc8bcd991f297448340213a.jpg',
                  'https://i.pinimg.com/564x/78/cc/49/78cc49e40b7192b893979cba4d8df5e5.jpg',
                  'https://i.pinimg.com/564x/4e/74/75/4e7475b8f32fd2ee9925e8230e94d4e0.jpg'
                ].map((i) {
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
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
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
                onTap: () {},
                child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Text("ما هو سؤالك  ؟",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 19, color: Colors.white)),
                    ),
                    decoration: BoxDecoration(
                      color: defaultColor,
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
                    return questionItem();
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
    ),
  );
}
