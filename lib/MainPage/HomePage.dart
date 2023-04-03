import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pa_pemo/CartPage.dart/CartPage.dart';
import 'package:pa_pemo/Controller/HomePageController.dart';
import 'package:pa_pemo/DetailPage/DetailPage.dart';
import 'package:pa_pemo/Model/models.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../ImageData/ImageData.dart';

DateTime now = DateTime.now();
final Waktu = DateTime.parse(now.toString());
final pagecontrol = PageController();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget hotdeals(String name, String gambar, String harga, String hargadiskon,
      Color background, Color foreground) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15),
      width: 150,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            child: FutureBuilder(
              future: ImageData.getImageURL(gambar),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Image.network(snapshot.data!);
                }
                return Lottie.asset("assets/109262-loading-circles.json");
              },
            ),
          ),
          Text(name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: foreground)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(harga,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough)),
              Text(hargadiskon,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                      decoration: TextDecoration.underline)),
            ],
          )
        ],
      ),
    );
  }

  Widget featuredFood(Makanan food, Color background, String description,
      String description1, String description2) {
    return Container(
      height: 150,
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Row(
        children: [
          SizedBox(width: 20),
          Container(
            width: 100,
            child: FutureBuilder(
              future: ImageData.getImageURL(food.gambar),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Image.network(snapshot.data!);
                }
                return Lottie.asset("assets/109262-loading-circles.json");
              },
            ),
          ),
          SizedBox(width: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(food.nama,
                  style: const TextStyle(
                      letterSpacing: 2,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const Text(
                "Crispy",
                style: TextStyle(color: Colors.white),
              ),
              const Text("Flavorful", style: TextStyle(color: Colors.white)),
              const Text("Well Seasoned",
                  style: TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController SearchController = TextEditingController();
    final page = Get.put(HomePageController());

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Waktu.hour >= 5 && Waktu.hour < 11
                        ? "Selamat Pagi"
                        : Waktu.hour >= 11 && Waktu.hour < 15
                            ? "Selamat Siang"
                            : Waktu.hour >= 15 && Waktu.hour < 19
                                ? "Selamat Sore"
                                : "Selamat Malam",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    "Ingin makan apa hari ini?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ]),
            GestureDetector(
              onTap: () {
                Get.to(CartPage());
              },
              child: Icon(Icons.shopping_cart_outlined,
                  color: Colors.deepOrange, size: 30),
            )
          ]),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text("Featured Food",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        const SizedBox(height: 30),
        Container(
          height: 150,
          child: PageView(controller: pagecontrol, children: [
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[0]));
                },
                child: featuredFood(page.food[0], Colors.amber, "Crispy",
                    "Flavorful", "Well Seasoned")),
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[1]));
                },
                child: featuredFood(page.food[1], Colors.red.shade200, "Crispy",
                    "Flavorful", "Well Seasoned")),
            InkWell(
                onTap: () {
                  Get.to(DetailPage(makanan: page.food[2]));
                },
                child: featuredFood(page.food[2], Colors.blue.shade200,
                    "Crispy", "Flavorful", "Well Seasoned")),
          ]),
        ),
        const SizedBox(height: 30),
        Center(
            child: SmoothPageIndicator(
                controller: pagecontrol,
                count: 3,
                effect: const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Color(0xFFFFFFB72B),
                    spacing: 15))),
        const Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text("HOT Deals",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        const SizedBox(height: 30),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              InkWell(
                  onTap: () {
                    Get.to(DetailPage(makanan: page.food[0]));
                  },
                  child: hotdeals(
                      page.food[0].nama,
                      page.food[0].gambar,
                      "32000",
                      page.food[0].harga.toString(),
                      Colors.blue.shade200,
                      Colors.blue.shade600)),
              InkWell(
                  onTap: () {
                    Get.to(DetailPage(makanan: page.food[4]));
                  },
                  child: hotdeals(
                      page.food[4].nama,
                      page.food[4].gambar,
                      "27000",
                      page.food[4].harga.toString(),
                      Colors.red.shade200,
                      Colors.red.shade600)),
              InkWell(
                  onTap: () {
                    Get.to(DetailPage(makanan: page.food[5]));
                  },
                  child: hotdeals(
                      page.food[5].nama,
                      page.food[5].gambar,
                      "35000",
                      page.food[5].harga.toString(),
                      Colors.yellow.shade600,
                      Colors.yellow.shade800)),
            ],
          ),
        )
      ],
    );
  }
}
