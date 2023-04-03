import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_pemo/Controller/HomePageController.dart';
import 'package:pa_pemo/MainPage/HomePage.dart';
import 'package:pa_pemo/MainPage/ProfilePage.dart';
import 'package:pa_pemo/MainPage/Riwayat.dart';
import '../Controller/Cartcontroller.dart';
import '../Controller/UserController.dart';
import 'CatalogPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Get.put(Cartcontroller());

    final _pageController = PageController();

    final page = Get.put(HomePageController());

    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: [HomePage(), CatalogPage(), RiwayatPage(), ProfilePage()],
          onPageChanged: (index) {
            page.setIndex(index);
          },
        ),
        bottomNavigationBar: Obx(
          () => CircleNavBar(
            shadowColor: Colors.white,
            initIndex: page.selectedIndex.value,
            onChanged: (v) {
              page.setIndex(v);
              _pageController.jumpToPage(page.GetIndex());
            },
            activeIcons: const [
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.list, color: Colors.white),
              Icon(Icons.list_alt_outlined, color: Colors.white),
              Icon(Icons.person, color: Colors.white),
            ],
            inactiveIcons: const [
              Text("Home", style: TextStyle(color: Colors.white)),
              Text("Catalog", style: TextStyle(color: Colors.white)),
              Text("Riwayat", style: TextStyle(color: Colors.white)),
              Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
            ],
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF2994A), Color(0xFFFFF2C94C)]),
            height: 50,
            circleWidth: 45,
            //) tabCurve: ,
            elevation: 10,
            color: Colors.white,
          ),
        ));
  }
}
