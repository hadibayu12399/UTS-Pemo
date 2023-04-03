import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pa_pemo/LandingPage/Landingpage.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/Burger.png'),
      title: const Text(
        "FastFood",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold, 
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.amber,
      loadingText: Text("FastFood - Grab your food now"),
      navigator: LandingPage(),
      durationInSeconds: 5,
    );
}}