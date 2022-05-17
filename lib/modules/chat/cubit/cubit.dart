import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:turtles_app/models/message_model.dart';
import 'package:turtles_app/models/post_model.dart';
import 'package:turtles_app/models/question_model.dart';
import 'package:turtles_app/modules/chat/cubit/states.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:turtles_app/shared/constants/constants.dart';

import '../../../shared/constants/components.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  List<QuestionModel> chatList = [];

  void sendMessageAndAsk(String question, ScrollController controllerList) {
    var questionModel = QuestionModel(
      question: question,
      answer: '',
      senderId: currentUid,
      id: '',
      time: timestamp.toString(),
    );
    chatList.add(questionModel);
    Future.delayed(const Duration(milliseconds: 50), () {
      controllerList.animateTo(controllerList.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
    emit(QuestionSuccessState());
    emit(AnswerLoadingState());

    getSearchSmallResult(question)
        .then((value) => {
              chatList.last.answer = value,
              Future.delayed(const Duration(milliseconds: 50), () {
                controllerList.animateTo(
                    controllerList.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }),
              emit(AnswerSuccessState()),
              sendMessageToFB(questionModel)
            })
        .catchError((error) => {
              print(error),
              emit(AnswerErrorState()),
            });
  }

  // delay function

  Future<String> getSearchSmallResult(String searchTest) async {
    final response = await http.Client()
        .get(Uri.parse('https://www.google.com/search?q=$searchTest'));
    String result = 'No result for  this search';
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      var responseString1 = document.querySelectorAll('div:nth-child(4)');
      result = removeEnglishLetters(responseString1[1].text.trim());
      print(responseString1[1].text.trim());
    }

    return result;
  }

  // remove all english letters
  String removeEnglishLetters(String text) {
    return text.replaceAll(RegExp(r'[a-zA-Z]'), '');
  }

  void sendMessageToFB(QuestionModel questionModel) {
    final newCityRef = FirebaseFirestore.instance
        .collection("chats")
        .doc(currentTurtle)
        .collection(currentUid)
        .doc();
    questionModel.id = newCityRef.id;
    newCityRef.set(questionModel.toJson());
  }

  void getUserChat() {
    chatList = [];
    FirebaseFirestore.instance
        .collection("chats")
        .doc(currentTurtle)
        .collection(currentUid)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                chatList.add(QuestionModel.fromJson(element.data()));
              }),
              emit(GetChatSuccessState()),
            })
        .catchError((error) => {
              print(error),
            });
  }

  void saveQuestionAsPost(QuestionModel questionModel) {
    final newCityRef = FirebaseFirestore.instance
        .collection("posts")
        .doc('userPosts')
        .collection(currentTurtle)
        .doc();

    List<Comment> list = [];
    var postModel = PostModel(
        newCityRef.id,
        questionModel.question,
        questionModel.answer,
        1,
        0,
        list,
        timestamp.toString(),
        userName,
        currentUid);

    newCityRef.set(postModel.toJson());
  }

}
