import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../controllers/monitor_controller.dart';

class MonitorView extends GetView<MonitorController> {
  const MonitorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.theme == false ? Colors.black : Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => IconButton(
                  padding: EdgeInsets.only(bottom: 100),
                  onPressed: () {
                    controller.theme_change();
                  },
                  icon: Icon(
                    Icons.light_mode_outlined,
                    size: 50,
                    color:
                        controller.theme == true ? Colors.amber : Colors.white,
                  )),
            ),
            SizedBox(
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'L',
                          style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 30,
                                  letterSpacing: -3.0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            'M',
                            style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: controller.theme == false
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 30,
                                    letterSpacing: -3.0)),
                          ),
                        ),
                        Text(
                          'H',
                          style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 30,
                                  letterSpacing: -3.0)),
                        ),
                      ],
                    ),
                  ),
                  //
                  Center(
                    child: CircularPercentIndicator(
                      radius: 135.0,
                      lineWidth: 11.0,
                      percent: 0.80,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Center(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Center(
                              child: Icon(
                                Icons.electric_bolt,
                                color: controller.theme == false
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade400,
                                size: 230,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 0, top: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 36,
                                            width: 27,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 36,
                                            width: 27,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade700,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(40.0),
                                                  bottomLeft:
                                                      Radius.circular(40.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        height: 145,
                                        width: 94,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(
                                            '160',
                                            style: GoogleFonts.oswald(
                                                textStyle: TextStyle(
                                                    color: controller.theme ==
                                                            false
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 70,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: -6.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            'KM',
                                            style: GoogleFonts.oswald(
                                                textStyle: TextStyle(
                                                    color: controller.theme ==
                                                            false
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 30,
                                                    letterSpacing: -3.0)),
                                          ),
                                          Text(
                                            '/',
                                            style: GoogleFonts.oswald(
                                                textStyle: TextStyle(
                                                    color: controller.theme ==
                                                            false
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 40,
                                                    letterSpacing: -3.0)),
                                          ),
                                          Text(
                                            'h',
                                            style: GoogleFonts.oswald(
                                                textStyle: TextStyle(
                                                    color: controller.theme ==
                                                            false
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 30,
                                                    letterSpacing: -3.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Text(
                                ' 90%',
                                style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        color: Colors.green,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -2.5)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      progressColor: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 17,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '8.76 ',
                    style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                            color: controller.theme == false
                                ? Colors.white
                                : Colors.black,
                            fontSize: 33,
                            letterSpacing: -3.0)),
                  ),
                  Text(
                    'Km ',
                    style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                            color: controller.theme == false
                                ? Colors.white
                                : Colors.black,
                            fontSize: 25,
                            letterSpacing: -3.0)),
                  ),
                ],
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
