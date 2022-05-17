import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turtles_app/layouts/home_layout/home_layout_screen.dart';
import 'package:turtles_app/shared/constants/constants.dart';
import 'package:turtles_app/shared/network/local/CachHelper.dart';
import 'package:turtles_app/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameControler = TextEditingController();
    var key = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: SvgPicture.asset(
                        'assets/images/back_ground_svg_wild_turtle.svg',
                        width: 100),
                  ),
                  Text(
                      'مرحبا بك, '
                      'ادخل اسمك للاستمرار',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: defaultColor)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: nameControler,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        label: const Center(child: Text('اسمك')),
                        hintStyle: const TextStyle(fontSize: 20),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: defaultColor),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخال الاسم اولا';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          userName = nameControler.text;
                          login().then((value) => {
                                if (value != null)
                                  {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(value.user!.uid)
                                        .set({
                                      'name': nameControler.text,
                                      'id': value.user!.uid,
                                    }).then((response) => {
                                              CacheHelper.saveData(
                                                  key: 'currentUid',
                                                  value: value.user!.uid),
                                              CacheHelper.saveData(
                                                      key: 'name',
                                                      value: nameControler.text)
                                                  .then((value) => {
                                                        currentUid = value,
                                                        navigateAndFinish(
                                                            context,
                                                            const HomeLayoutScreen()),
                                                      }),
                                            }),
                                  }
                              });
                        }
                      },
                      child:
                          const Text('الدخول', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential?> login() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
      return null;
    }
  }
}
