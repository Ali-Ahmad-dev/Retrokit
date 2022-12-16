import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:retrokit/app/modules/monitor/bindings/monitor_binding.dart';
import 'package:retrokit/app/modules/monitor/views/monitor_view.dart';
import 'package:spring/spring.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final SpringController springController =
      SpringController(initialAnim: Motion.reverse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: SizedBox(
                width: 230,
                child: Image.asset(
                  'assets/Retrokit Vector logo.png',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Spring.slide(
                  springController: springController,
                  slideType: SlideType.slide_in_right,
                  delay: Duration(milliseconds: 3000),
                  animDuration: Duration(milliseconds: 3000),
                  curve: Curves.linear,
                  extend: 200,
                  withFade: false,
                  animStatus: (AnimStatus status) {
                    if (status == AnimStatus.dismissed) {
                      Get.to(() => MonitorView(), binding: MonitorBinding());
                    }
                  },
                  child: Container(
                      width: 250,
                      child: Image.asset(
                        'assets/Retrokit Vector.png',
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
