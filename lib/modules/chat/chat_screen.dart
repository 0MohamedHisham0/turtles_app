import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turtles_app/styles/colors.dart';

import '../../shared/constants/components.dart';
import '../../shared/constants/constants.dart';
import '../chat/cubit/cubit.dart';
import '../chat/cubit/states.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    var controllerList = ScrollController();
    return BlocProvider(
        create: (context) =>
        ChatCubit()
          ..getUserChat(),
        child: BlocConsumer<ChatCubit, ChatStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = BlocProvider.of<ChatCubit>(context);
              askQuestion() {
                cubit.sendMessageAndAsk(textController.text, controllerList);
                textController.clear();
              }

              const SizedBox(
                height: 40,
              );

              return Scaffold(
                appBar: AppBar(
                  title: const Text('المحادثة'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ConditionalBuilder(
                          condition: cubit.chatList.isEmpty,
                          builder: (context) =>
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          if (currentTurtle == 'wild')
                                            SvgPicture.asset(
                                              'assets/images/back_ground_svg_wild_turtle.svg',
                                              width: 40,
                                            ),
                                          if (currentTurtle == 'sea')
                                            SvgPicture.asset(
                                              'assets/images/water-solid.svg',
                                              color: defaultColor,
                                              width: 40,
                                            ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'لا يوجد رسائل حتى الآن',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: defaultColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          fallback: (context) {
                            return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                controller: controllerList,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      chatSentItem(
                                          cubit.chatList[index].question
                                              .toString(),
                                          timestampToDate(cubit
                                              .chatList[index].time
                                              .toString())),
                                      if (cubit.chatList[index].answer != '')
                                        chatReceivedItem(
                                            cubit.chatList[index].answer
                                                .toString(),
                                            timestampToDate(cubit
                                                .chatList[index].time
                                                .toString()),(){
                                              cubit.saveQuestionAsPost(cubit.chatList[index]);
                                        }),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                                itemCount: cubit.chatList.length);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.send,
                                  autofocus: true,
                                  controller: textController,
                                  onSubmitted: (s) => askQuestion(),
                                  decoration: const InputDecoration(
                                      hintText: 'اكتب سؤالك هنا',
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder()),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: defaultColor,
                                ),
                                onPressed: () {
                                  if (textController.text != '') {
                                    askQuestion();
                                  } else {
                                    showToast(
                                        text: 'الرجاء ادخال السؤال اولا',
                                        state: ToastStates.WARNING);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  Widget chatSentItem(String text, String time) {
    // chat item
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 50),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: defaultColor,
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(text,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
                Text(time,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chatReceivedItem(String text, String time, Function onTap) {
    // chat item
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 50),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.4),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(text,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          letterSpacing: 0.5,
                          wordSpacing: 0.5,
                          height: 1.5,
                          fontSize: 20,
                        )),
                    Text(time,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        )),
                  ],
                ),
              ),
              myDivider(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12)),
                      onTap: () {
                        showToast(text: 'تم تقيم السؤال بنجاح',
                            state: ToastStates.SUCCESS);
                        onTap();
                      },
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
                                style: TextStyle(
                                    fontSize: 19, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showToast(text: 'تم تقيم السؤال بنجاح',
                            state: ToastStates.SUCCESS);
                      },
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
                                style: TextStyle(
                                    fontSize: 19, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
