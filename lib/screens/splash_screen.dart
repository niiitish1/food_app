import 'package:flutter/material.dart';
import 'package:food_app/animation/fade_in.dart';
import 'package:food_app/onboading/onboarding.dart';
import 'package:food_app/screens/home.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var arr = [];
  @override
  void initState() {
    super.initState();
    checkOnBoarding();
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

  checkOnBoarding() {
    SharedPreferences.getInstance().then((value) {
      if (value.getBool('onBoarding_done') ?? false) {
        Future.delayed(Duration(seconds: 3)).then((value) {
          return Navigator.pushReplacement(
              context, FadeInRoute(page: HomePage()));
        });
      } else {
        Future.delayed(Duration(seconds: 3)).then((value) {
          return Navigator.pushReplacement(
              context, FadeInRoute(page: OnBoarding()));
        });
      }
    });
  }
}
