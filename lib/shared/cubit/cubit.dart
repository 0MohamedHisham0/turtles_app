import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:turtles_app/models/post_model.dart';
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
  List<PostModel> postsSea = [];
  List<PostModel> postsWild = [];

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

  void getSeaPosts() {
    emit(TurtlesAppGetPostsSuccessState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc('userPosts')
        .collection('sea')
        .get()
        .then((value) {
      postsSea = [];
      value.docs.forEach((element) {
        postsSea.add(PostModel.fromJson(element.data()));
      });
      emit(TurtlesAppGetPostsSuccessState());
    }).catchError((error) {
      emit(TurtlesAppGetPostsErrorState());
      print(error);
    });
  }

  void getWildPosts() {
    emit(TurtlesAppGetPostsSuccessState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc('userPosts')
        .collection('wild')
        .get()
        .then((value) {
      postsWild = [];
      value.docs.forEach((element) {
        postsWild.add(PostModel.fromJson(element.data()));
      });

      emit(TurtlesAppGetPostsSuccessState());
    }).catchError((error) {
      emit(TurtlesAppGetPostsErrorState());
      print(error);
    });
  }

  void checkIfUserRate(String postId, String likeOrDislike) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc('userPosts')
        .collection(currentTurtle)
        .doc(postId)
        .get()
        .then((value) {
      if (value.data() != null) {
        PostModel post = PostModel.fromJson(value.data()!);

        if (!post.raters!.contains(currentUid) || post.raters == null) {
          if (likeOrDislike == 'like') {
            print('like');
            likePost(postId);
            return;
          }
          if (likeOrDislike == 'dislike') {
            print('dislike');

            unLikePost(postId);
            return;
          }
        } else {
          showToast(
              text: 'لقد قمت بتقييم هذا السؤال من قبل',
              state: ToastStates.WARNING);
        }
      }
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc('userPosts')
        .collection(currentTurtle)
        .doc(postId)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc('userPosts')
          .collection(currentTurtle)
          .doc(postId)
          .update({'likes': value.data()!['likes'] + 1}).then((value) {
        showToast(text: "تم تقيم السؤال بنجاح", state: ToastStates.SUCCESS);
        FirebaseFirestore.instance
            .collection('posts')
            .doc('userPosts')
            .collection(currentTurtle)
            .doc(postId)
            .update({
          'raters': FieldValue.arrayUnion([currentUid])
        });
      });
    });
  }

  void unLikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc('userPosts')
        .collection(currentTurtle)
        .doc(postId)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc('userPosts')
          .collection(currentTurtle)
          .doc(postId)
          .update({'unLikes': value.data()!['unLikes'] + 1}).then((value) =>
              showToast(
                  text: "تم تقيم السؤال بنجاح", state: ToastStates.SUCCESS));
    }).catchError((error) {
      print(error);
    });
  }

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
}
