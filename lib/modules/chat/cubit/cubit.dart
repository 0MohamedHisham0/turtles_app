import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

  //Ad Mob Banner
  BannerAdListener listener = const BannerAdListener();
  late BannerAd myBanner;

  void loadAndListenToAd() {
    myBanner = BannerAd(
      adUnitId: adUnitBanner,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: listener,
    );

    myBanner.load();

    listener = BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => emit(AdLoadedSuccessState()),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => myBanner.dispose(),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => myBanner.dispose(),
    );
  }

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
              if (value.contains('عرض النتائج عن'))
                {
                  print(removeSigns(value)),
                  chatList.last.answer = " هل تقصد${removeSigns(value)}",
                  Future.delayed(const Duration(milliseconds: 50), () {
                    controllerList.animateTo(
                        controllerList.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }),
                  emit(AnswerSuccessState()),
                }
              else
                {
                  chatList.last.answer = value,
                  Future.delayed(const Duration(milliseconds: 50), () {
                    controllerList.animateTo(
                        controllerList.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }),
                  emit(AnswerSuccessState()),
                  sendMessageToFB(questionModel)
                }
            })
        .catchError((error) {
      print(error);
      emit(AnswerErrorState());
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
    List<String> raters = [];

    var postModel = PostModel(
        newCityRef.id,
        questionModel.question,
        questionModel.answer,
        0,
        0,
        list,
        raters,
        timestamp.toString(),
        userName,
        currentUid);

    newCityRef.set(postModel.toJson());
  }

  // remove all signs and numbers from string
  String removeSigns(String text) {
    return text
        .split('عرض النتائج عن')
        .toString()
        .replaceAll(RegExp(r'[\d]'), '')
        .replaceAll('البحث', '')
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('&', '')
        .replaceAll('#', '')
        .replaceAll(';', '')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('\'', '')
        .replaceAll('"', '')
        .replaceAll('.', '')
        .replaceAll('=', '')
        .replaceAll(',', '');
  }
}
