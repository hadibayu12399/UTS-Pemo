import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pa_pemo/MainPage/MainPage.dart';

import '../Controller/RegisController.dart';
import '../Controller/UserController.dart';

final SignInUpController signInUpController = Get.put(SignInUpController());
final UserController userController = Get.put(UserController());

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.width;
    return Scaffold(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.black, size: 12),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.white, // <-- Button color
                  onPrimary: Colors.black, // <-- Splash color
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Log in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.deepOrange,
                ),
              )),
          Container(
            margin: EdgeInsets.all(20),
            height: 50,
            child: TextField(
              controller: signInUpController.emailController,
              decoration: InputDecoration(
                  labelText: 'Alamat Email',
                  labelStyle: TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.deepOrange),
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: 50,
            child: TextField(
              obscureText: true,
              controller: signInUpController.passwordController,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.deepOrange),
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: signInUpController.emailController.text.trim(),
                  password: signInUpController.passwordController.text,
                );
                var userID = FirebaseAuth.instance.currentUser!.uid;
                userController.setUid(userID);

                Get.to(() => MainPage());
              } on FirebaseAuthException catch (e) {
                Get.dialog(
                  AlertDialog(
                    content: Text(e.message!),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Tutup"),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Container(
                padding: EdgeInsets.only(top: 10),
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.deepOrange),
                width: width,
                height: height / 9,
                child: const Text(
                  "Log in",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
