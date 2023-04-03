import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_pemo/Controller/UserController.dart';
import 'package:intl/intl.dart';

import '../Controller/Cartcontroller.dart';
import '../ImageData/ImageData.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  String formattedDate =
      DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

  final Cartcontroller cartController = Get.put(Cartcontroller());

  Widget catalogList(String judul, int harga, int jumlah, String gambar,
      Function tambah, Function kurang) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
      height: 100,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 4,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          FutureBuilder(
            future: ImageData.getImageURL(gambar),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Image.network(snapshot.data!);
              }
              return CircularProgressIndicator();
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                judul,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    harga.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.yellow),
                  ),
                  const SizedBox(width: 30),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white70,
                    child: IconButton(
                        color: Colors.black,
                        padding: const EdgeInsets.all(5),
                        iconSize: 12,
                        icon: const Icon(Icons.add_outlined),
                        onPressed: () {
                          tambah();
                        }),
                  ),
                  const SizedBox(width: 10),
                  Text(jumlah.toString()),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white70,
                    child: IconButton(
                        color: Colors.black,
                        padding: const EdgeInsets.all(5),
                        iconSize: 12,
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          kurang();
                        }),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  var totalHarga = 0;
  var hargaSatuan = 0;

  @override
  Widget build(BuildContext context) {
    UserController controller = Get.put(UserController());
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection("keranjang");
    final Query kueri = user
        .where("user", isEqualTo: controller.uid)
        .where("status", isEqualTo: "pending");

    FirebaseFirestore riwayatStore = FirebaseFirestore.instance;
    CollectionReference riwayat = riwayatStore.collection("riwayat");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Keranjang Belanja",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: kueri.snapshots(),
                  builder: (_, snapshot) {
                    return (snapshot.hasData)
                        ? Column(
                            children: snapshot.data!.docs
                                .map(
                                  (e) => catalogList(
                                      e.get('nama'),
                                      e.get('harga'),
                                      e.get('jumlah'),
                                      e.get('gambar'), () {
                                    user.doc(e.id).update({
                                      'jumlah': e.get('jumlah') + 1,
                                    });
                                    hargaSatuan = e.get('harga');
                                    cartController.totalHarga.value +=
                                        hargaSatuan;
                                    cartController.totalItem += 1;
                                  }, () {
                                    if (e.get('jumlah') > 1) {
                                      user.doc(e.id).update({
                                        'jumlah': e.get('jumlah') - 1,
                                      });
                                    } else {
                                      user.doc(e.id).delete();
                                    }
                                    hargaSatuan = e.get('harga');
                                    cartController.totalHarga.value -=
                                        hargaSatuan;
                                    cartController.totalItem -= 1;
                                  }),
                                )
                                .toList(),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
              SizedBox(height: 100)
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.05,
            minChildSize: 0.05,
            maxChildSize: 0.45,
            builder: (BuildContext context, ScrollController s) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
                child: ListView(controller: s, children: [
                  Center(
                    child: Container(
                      height: 8,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("SUBTOTAL",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Obx(() => Text(
                              "Rp. ${cartController.totalHarga.value}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("TAX & FEE",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Obx(() => Text(
                              "Rp. ${(cartController.totalHarga.value * 0.1).toInt()} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("TOTAL",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Obx(() => Text(
                              "Rp. ${cartController.totalHarga.value + (cartController.totalHarga.value * 0.1).toInt()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: Colors.amber,
                            elevation: 5.0,
                          ),
                          onPressed: () {
                            riwayat.add({
                              'totalHarga': (cartController.totalHarga.value +
                                      (cartController.totalHarga.value * 0.1))
                                  .toInt(),
                              'totalItem': cartController.totalItem.value,
                              'user': controller.uid,
                              'tanggal': formattedDate,
                            });
                            cartController.deleteData();
                            cartController.totalHarga.value = 0;

                            Get.dialog(AlertDialog(
                              elevation: 5,
                              content: const Text(
                                  "Pembayaran berhasil"),
                              title: const Center(child: Text("Berhasil",style:TextStyle(color:Colors.green))),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("Tutup"),
                                ),
                              ],
                            ));
                          },
                          child: Text("CHECKOUT"),
                        ),
                      ),
                    ],
                  ),
                ]),
              );
            },
          ),
        ],
      ),
    );
  }
}
