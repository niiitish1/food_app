import 'package:flutter/material.dart';
import 'package:food_app/animation/fade_in.dart';
import 'package:food_app/onboading/onboarding.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      return Navigator.pushReplacement(
          context, FadeInRoute(page: OnBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: LottieBuilder.asset(
            'assets/splashscreen_bike.json',
            repeat: true,
            animate: true,
          ),
        ),
      ),
    );
  }
}
