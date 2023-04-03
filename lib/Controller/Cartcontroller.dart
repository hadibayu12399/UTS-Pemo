import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_pemo/Controller/UserController.dart';
import 'package:pa_pemo/Model/models.dart';

import '../Model/cart.dart';

class Cartcontroller extends GetxController {
  UserController controller = Get.put(UserController());

  var totalHarga = 0.obs;
  var keranjang = [];
  var totalItem = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    await FirebaseFirestore.instance
        .collection("keranjang")
        .where("user", isEqualTo: controller.uid.toString())
        .where("status", isEqualTo: "pending")
        .get()
        .then(
          (value) => {
            for (var i in value.docs)
              {
                keranjang.add(
                  Cart(
                    i.get("nama"),
                    i.get("harga"),
                    i.get("jumlah"),
                    i.get("status"),
                    i.get("user"),
                    i.get("gambar"),
                  ),
                ),
                for (int p = 0; p < i.get("jumlah"); p++)
                  {
                    totalHarga += i.get("harga"),
                  },
                totalItem += i.get("jumlah")
              }
          },
        );
  }

  void deleteData() async {
    await FirebaseFirestore.instance
        .collection("keranjang")
        .where("user", isEqualTo: controller.uid)
        .get()
        .then(
          (value) => {
            for (var i in value.docs)
              {
                FirebaseFirestore.instance
                    .collection("keranjang")
                    .doc(i.id)
                    .update({"status": "done"})
              }
          },
        );
  }
}
