import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:turtles_app/models/chat_model.dart';
import 'package:turtles_app/modules/chat/cubit/states.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  List<ChatModel> chatList = [];

  void sendMessageAndAsk(String message, ScrollController controllerList) {
    var chat = ChatModel("1", message, "1", DateTime.now().toString());
    chatList.add(chat);
    Future.delayed(const Duration(milliseconds: 50), () {
      controllerList.animateTo(controllerList.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease);
    });
    emit(QuestionSuccessState());
    emit(AnswerLoadingState());

    getSearchSmallResult(message)
        .then((value) => {
              chatList
                  .add(ChatModel("2", value, "1", DateTime.now().toString())),
              Future.delayed(const Duration(milliseconds: 50), () {
                controllerList.animateTo(controllerList.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }),

              emit(AnswerSuccessState()),
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
}
