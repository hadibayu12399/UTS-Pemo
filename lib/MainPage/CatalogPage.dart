import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Controller/HomePageController.dart';
import '../DetailPage/DetailPage.dart';
import '../ImageData/ImageData.dart';

class CatalogPage extends StatelessWidget {
  CatalogPage({Key? key}) : super(key: key);

  Widget hotdeals(String name, String gambar, String harga, Color background) {
    return Container(
      width: 150,
      height: 190,
      child: Card(
        elevation: 5,
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.only(left: 15),
              child: FutureBuilder(
              future: ImageData.getImageURL(gambar),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Image.network(snapshot.data!);
                }
                return Lottie.asset("assets/109262-loading-circles.json");
              },
            ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Colors.white)),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  final page = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text("Aneka makanan menarik",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Makan enak & hemat",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[2]));
                },
                child: hotdeals(page.food[2].nama, page.food[2].gambar, page.food[2].harga.toString(),
                    Colors.blue.shade200)),
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[5]));
                },
                child: hotdeals(
                    page.food[5].nama, page.food[5].gambar, page.food[5].harga.toString(), Colors.blue.shade200)),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[4]));
                },
                child: hotdeals(page.food[4].nama, page.food[4].gambar, page.food[4].harga.toString(), Colors.red.shade200)),
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[0]));
                },
                child: hotdeals(page.food[0].nama, page.food[0].gambar, page.food[0].harga.toString(),
                    Colors.red.shade200)),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[3]));
                },
                child: hotdeals(page.food[3].nama, page.food[3].gambar, page.food[3].harga.toString(),
                    Colors.yellow.shade400)),
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[1]));
                },
                child: hotdeals(page.food[1].nama, page.food[1].gambar, page.food[1].harga.toString(),
                    Colors.yellow.shade400)),
          ],
        ),
        const SizedBox(height: 30)
      ],
    );
  }
}
