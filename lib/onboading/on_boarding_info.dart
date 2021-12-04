import 'package:flutter/material.dart';
import 'package:food_app/screens/home.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingInfo {
  final title;
  final desc;
  final image;
  OnBoardingInfo(this.image, this.title, this.desc);
}

class OnBoardingList extends GetxController {
  var selectindex = 0.obs;
  final pageController = PageController();
  bool get isLastPage => selectindex.value == boardinglist.length - 1;

  nextpage(BuildContext context) {
    if (!isLastPage) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      SharedPreferences.getInstance().then((value) {
        value.setBool('onBoarding_done', true);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  List<OnBoardingInfo> boardinglist = [
    OnBoardingInfo('assets/order.png', 'Order Your Food',
        'Now you can order food any time  right from your mobile.'),
    OnBoardingInfo('assets/cook.png', 'Cooking Safe Food',
        'We are maintain safty and We keep clean while making food.'),
    OnBoardingInfo('assets/deliver.png', 'Quick Delivery',
        'Orders your favorite meals will be  immediately deliver')
  ];
}
