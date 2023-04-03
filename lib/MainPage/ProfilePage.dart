import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/UserController.dart';
import '../EditProfile/EditProfile.dart';
import '../LandingPage/Landingpage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 75,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/Burger.png'),
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(userController.nama.value,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            const SizedBox(height: 7),
            Text(userController.email,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.amber)),
            const SizedBox(
              height: 30,
              width: 20,
            ),
            Container(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.white,
                  elevation: 3.0,
                ),
                onPressed: () {
                  Get.to(EditProfile());
                },
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.white,
                  elevation: 3.0,
                ),
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                      contentPadding: EdgeInsets.only(left: 25, right: 25),
                      title: const Center(child: Text("Privacy Policy")),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      content: Container(
                        height: 200,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  'GroupTwo built the FastFood app as a Free app. This SERVICE is provided by GroupTwo at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.'),
                            ],
                          ),
                        ),
                      ));

                  showDialog(context: context, builder: (context) => alert);
                },
                child: const Text(
                  "Privacy Policy",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
            Container(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.white,
                  elevation: 3.0,
                ),
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                      contentPadding: EdgeInsets.only(left: 25, right: 25),
                      title: const Center(child: Text("About Us")),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      content: Container(
                        height: 200,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              SizedBox(
                                height: 30,
                              ),
                              Text("Sebuah tim yang memiliki minat pada pengembangan aplikasi ponsel berbasis Android. Terampil dalam kolaborasi antar tim, pemecahan masalah, dan manajemen proyek.")
                            ],
                          ),
                        ),
                      ));

                  showDialog(context: context, builder: (context) => alert);

                },
                child: const Text(
                  "About Us",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
            Container(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.white,
                  elevation: 3.0,
                ),
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                      contentPadding: EdgeInsets.only(left: 25, right: 25),
                      title: const Center(child: Text("App Version")),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      content: Container(
                        height: 200,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              SizedBox(
                                height: 30,
                              ),
                              Text("App Version : 0.0.1")
                            ],
                          ),
                        ),
                      ));

                  showDialog(context: context, builder: (context) => alert);
                },
                child: const Text(
                  "App Version",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
            Container(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.red.shade300,
                  elevation: 3.0,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.off(LandingPage());
                },
                child: const Text(
                  "Log out",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
