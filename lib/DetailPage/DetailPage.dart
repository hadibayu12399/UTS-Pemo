import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pa_pemo/CartPage.dart/CartPage.dart';
import 'package:pa_pemo/ImageData/ImageData.dart';
import 'package:pa_pemo/Model/models.dart';
import '../Controller/Cartcontroller.dart';
import '../Controller/UserController.dart';

class DetailPage extends StatelessWidget {
  final cart = Get.put(Cartcontroller());

  final Makanan makanan;

  DetailPage({Key? key, required this.makanan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference order = firestore.collection("keranjang");

    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                width: 50,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: Colors.black, size: 12),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: Colors.white, // <-- Button color
                    onPrimary: Colors.black, // <-- Splash color
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(CartPage());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, right: 20),
                  child: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.deepOrange, size: 30),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 300,
            // child: Image.asset(makanan.gambar),
            child: FutureBuilder(
              future: ImageData.getImageURL(makanan.gambar),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Image.network(snapshot.data!);
                }
                return Lottie.asset("assets/109262-loading-circles.json");
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.purple[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 35,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(makanan.rating,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 35,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${makanan.kalori} Kalori",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14))
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_money,
                        size: 35, color: Colors.green[200]),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Rp. ${makanan.harga}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
              margin: const EdgeInsets.only(
                left: 20,
              ),
              child: Text(makanan.nama,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: const EdgeInsets.only(
                left: 20,
              ),
              child: Text(makanan.deskripsi, style: TextStyle(fontSize: 15))),
          const SizedBox(
            height: 50,
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
                order.add({
                  'nama': makanan.nama,
                  'harga': makanan.harga,
                  'user': userController.uid,
                  'jumlah': 1,
                  'status': "pending",
                  'gambar': makanan.gambar,
                });

                cart.totalHarga += makanan.harga;
                cart.totalItem += 1;

                
                Get.dialog(AlertDialog(
                  elevation: 5,
                  content:
                      const Text("Makanan telah ditambahkan kedalam keranjang"),
                  title: const Center(child: Text("Berhasil")),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Tutup"),
                    ),
                  ],
                ));
              },
              child: Text("TAMBAH KE KERANJANG"),
            ),
          ),
        ],
      ),
    );
  }
}
