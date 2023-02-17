import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:retrokit/app/modules/home/bindings/home_binding.dart';
import 'package:retrokit/app/modules/home/views/home_view.dart';
import 'package:retrokit/app/modules/monitor/bindings/monitor_binding.dart';
import 'package:retrokit/app/modules/monitor/views/monitor_view.dart';
import 'package:retrokit/styles/colors.dart';
import 'package:spring/spring.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final SpringController springController =
      SpringController(initialAnim: Motion.play);
  final SpringController _controller =
      SpringController(initialAnim: Motion.play);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors().text_color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 60),
              child: Align(
                alignment: Alignment.center,
                child: Spring.slide(
                  springController: springController,
                  slideType: SlideType.slide_in_right,
                  delay: Duration(milliseconds: 0),
                  animDuration: Duration(milliseconds: 2500),
                  curve: Curves.linear,
                  withFade: false,
                  extend: 200,
                  animStatus: (AnimStatus status) {
                    if (status == AnimStatus.completed) {
                      Get.to(() => HomeView(), binding: HomeBinding());
                    }
                  },
                  child: Container(
                      width: 220,
                      child: Image.asset(
                        'assets/images/Retrokit Vector logo.png',
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.center,
                child: Spring.slide(
                  springController: _controller,
                  slideType: SlideType.slide_in_left,
                  delay: Duration(milliseconds: 0),
                  animDuration: Duration(milliseconds: 2500),
                  curve: Curves.linear,
                  withFade: false,
                  extend: -200,
                  animStatus: (AnimStatus status) {
                    if (status == AnimStatus.completed) {
                      Get.to(() => HomeView(), binding: HomeBinding());
                    }
                  },
                  child: Container(
                      width: 220,
                      child: Image.asset(
                        'assets/images/Retrokit Vector.png',
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
