import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var uid = "";
  var nama = "".obs;
  String email = "";
  var noTelp = "".obs;

  void setUid(String UID) {
    uid = UID;
    getProfile(uid);
  }

  void getProfile(String uid) {
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      nama.value = value.get("nama");
      email = value.get("email");
      noTelp.value = value.get("noTelp");
    });
  }

  void setProfile(String Nama, String email, String noTelp) {
    nama.value = Nama;
    this.email = email;
    this.noTelp.value = noTelp;
  }
}
