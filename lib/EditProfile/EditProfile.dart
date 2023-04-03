import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_pemo/Controller/EditProfileController.dart';

import '../LoginPage/LoginPage.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection("users");

    final EditProfileController profileController =
        Get.put(EditProfileController());

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
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 65,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/Burger.png'),
                  backgroundColor: Colors.white,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(userController.nama.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
                  Text(userController.email,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.amber)),
                ],
              )
            ],
          ),
          SizedBox(height: 30),
          const Padding(
            padding: const EdgeInsets.only(left: 21.0),
            child: Text("Nama",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: 50,
            child: TextField(
              controller: profileController.editNamaController,
              decoration: InputDecoration(
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
          const Padding(
            padding: const EdgeInsets.only(left: 21.0),
            child: Text("Nomor Telepon",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.phone,
              maxLength: 11,
              controller: profileController.editNotelpController,
              decoration: InputDecoration(
                  counterText: "",
                  prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(15, 17, 15, 15),
                      child: Text('+62 ')),
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
            height: 50,
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: Colors.amber,
                elevation: 5.0,
              ),
              onPressed: () {
                AlertDialog alert = AlertDialog(
                  title: Text("Konfirmasi"),
                  content: Container(
                    child: Text("Apakah anda ingin mengubah profile anda?"),
                  ),
                  actions: [
                    TextButton(
                        child: Text('TIDAK'), onPressed: () => Get.back()),
                    TextButton(
                        child: Text('YA'),
                        onPressed: () {
                          user.doc(userController.uid).update({
                            'nama': profileController.editNamaController.text,
                            'noTelp':
                                "0${profileController.editNotelpController.text}",
                          });
                          userController.nama.value =
                              profileController.editNamaController.text;
                          userController.noTelp.value =
                              profileController.editNotelpController.text;
                          Get.back();
                        }),
                  ],
                );
                if (profileController.validateSignUp()) {
                  showDialog(context: context, builder: (context) => alert);
                }
              },
              child: Text("EDIT PROFILE"),
            ),
          ),
        ],
      ),
    );
  }
}
