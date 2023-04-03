import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../Controller/UserController.dart';

class RiwayatPage extends StatelessWidget {
  RiwayatPage({Key? key}) : super(key: key);

  String formattedDate =
      DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

  Widget riwayat(int totalHarga, int totalItem, String tanggal) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
          height: 170,
          width: double.infinity,
          child: Card(
            color: Colors.white70,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Success",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        tanggal,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12 + 1,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: 10),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Text("Rp. $totalHarga",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Text("$totalItem Items",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserController controller = Get.put(UserController());
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection("riwayat");
    final Query kueri = user.where("user", isEqualTo: controller.uid);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text("Riwayat Pemesanan",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 20),
        StreamBuilder<QuerySnapshot>(
            stream: kueri.snapshots(),
            builder: (_, snapshot) {
              return (snapshot.hasData)
                  ? Column(
                      children: snapshot.data!.docs
                          .map(
                            (e) => riwayat(
                              e.get('totalHarga'),
                              e.get('totalItem'),
                              e.get('tanggal'),
                            ),
                          )
                          .toList(),
                    )
                  : Center(
                      child:
                          Lottie.asset("assets/109262-loading-circles.json"));
            }),
      ],
    );
  }
}
