import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pa_pemo/Controller/RegisController.dart';
import 'package:pa_pemo/Controller/UserController.dart';
import 'package:pa_pemo/MainPage/MainPage.dart';

import '../LandingPage/Landingpage.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInUpController signInUpController = Get.put(SignInUpController());
    final UserController userController = Get.put(UserController());

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
            height: 20,
          ),
          const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Buat akun baru",
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
              controller: signInUpController.nameController,
              decoration: InputDecoration(
                  labelText: 'Nama Panjang',
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
              keyboardType: TextInputType.phone,
              maxLength: 11,
              controller: signInUpController.phoneController,
              decoration: InputDecoration(
                counterText: "",
              prefixIcon: Padding(padding: EdgeInsets.fromLTRB(15,17,15,15), child: Text('+62 ')),
                  labelText: 'Nomor Telepon',
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
              obscureText:true,
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
          Container(
            margin: EdgeInsets.all(20),
            height: 50,
            child: TextField(
              controller: signInUpController.passwordConfirmController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Re type Password',
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
            onTap: () {
              Get.to(MainPage());
            },
            child: Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.symmetric(horizontal: 40),
              width: width,
              height: height / 7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Colors.deepOrange,
                  elevation: 10.0,
                ),
                onPressed: () async {
                  if (signInUpController.validateSignUp()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: signInUpController.emailController.text.trim(),
                        password: signInUpController.passwordController.text,
                      );

                      var userID = FirebaseAuth.instance.currentUser!.uid;
                      userController.uid = userID;
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(userID)
                          .set({
                        "nama": signInUpController.nameController.text,
                        "email": signInUpController.emailController.text,
                        "noTelp": signInUpController.phoneController.text,
                      });
                      userController.setProfile(
                          signInUpController.nameController.text,
                          signInUpController.emailController.text,
                          signInUpController.phoneController.text);
                      Get.to(() => LandingPage());
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
                  }
                },
                child: Text("Daftar"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
