import 'package:flutter/material.dart';
import 'package:food_app/onboading/on_boarding_info.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  

  final controller = OnBoardingList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.selectindex,
              itemCount: controller.boardinglist.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(controller.boardinglist[index].image),
                    SizedBox(height: 20),
                    Text(
                      controller.boardinglist[index].title,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Text(controller.boardinglist[index].desc,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                );
              },
            ),
            Obx(() {
              return Positioned(
                bottom: 28,
                left: 20,
                child: Row(
                  children:
                      List.generate(controller.boardinglist.length, (index) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.selectindex.value == index
                            ? Colors.red
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              );
            }),
            Obx(() {
              return Positioned(
                right: 16,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    controller.nextpage(context);
                  },
                  child: Text(controller.isLastPage ? 'Start' : 'Next'),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
