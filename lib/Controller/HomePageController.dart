import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_pemo/Model/models.dart';

class HomePageController extends GetxController {
  var selectedIndex = 0.obs;

  void setIndex(Index) {
    selectedIndex.value = Index;
  }

  int GetIndex() {
    return selectedIndex.value;
  }

  var food = <Makanan>[];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    await FirebaseFirestore.instance.collection("makanan").get().then(
          (value) => {
            for (var i in value.docs)
              {
                food.add(
                  Makanan(
                    i.get("nama"),
                    i.get("harga"),
                    i.get("rating"),
                    i.get("gambar"),
                    i.get("kalori"),
                    i.get("deskripsi"),
                  ),
                ),
              }
          },
        );

    
      //   firestore.docs.map((e) {
      //     food.add(
      //       Makanan(
      //         e.get("nama"),
      //         e.get("harga"),
      //         e.get("rating"),
      //         e.get("gambar"),
      //         e.get("kalori"),
      //         e.get("deskripsi"),
      //       ),
      //     );
      //     print(e.get("gambar"));
      //   });
      // }
    }
  }

