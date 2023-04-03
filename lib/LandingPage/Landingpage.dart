import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pa_pemo/LoginPage/LoginPage.dart';
import 'package:pa_pemo/LoginPage/RegisterPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Controller/Cartcontroller.dart';
import '../Controller/HomePageController.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final page = Get.put(HomePageController());

    final _controller = PageController();
    

    double width = Get.width;
    double height = Get.width;

    Widget Page(String title, String animation) {
      return Container(
        padding: EdgeInsets.only(left: 10, bottom: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selamat datang ke fast food",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              Lottie.asset(animation, repeat: false),
            ]),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {},
            controller: _controller,
            children: [
              Page("Pesan makanan dan minuman favoritemu", "assets/Food.json"),
              Page("Lakukan pemesanan dimanapun dan kapanpun",
                  "assets/orderfood.json"),
              Page("Beragam metode pembayaran", "assets/Payment.json"),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.50),
            child: SmoothPageIndicator(
                onDotClicked: (index) {
                  _controller.jumpToPage(index);
                },
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.lightBlue,
                    spacing: 15)),
          ),
          Align(
            alignment: Alignment(0, 0.70),
            child: InkWell(
              onTap: () {
                Get.to(RegisterPage());
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepOrange),
                  width: width,
                  height: height / 9,
                  child: const Text(
                    "Sign up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.88),
            child: InkWell(
              onTap: () {
                Get.to(LoginPage());
              },
              child: Container(
                  padding: EdgeInsets.only(top: 10),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]),
                  width: width,
                  height: height / 9,
                  child: const Text(
                    "Log in",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepOrange,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
