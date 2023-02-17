import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_battery_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_controller_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_motor_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_voltage_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_warning_view.dart';
import 'package:retrokit/styles/colors.dart';
import '../controllers/selection_controller.dart';

class SelectionView extends GetView<SelectionController> {
  const SelectionView({super.key});

  _containers(routes, icons, names) {
    return Bounce(
      duration: Duration(milliseconds: 170),
      onPressed: () {
        routes;
      },
      child: Card(
        color: colors().backGround,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: colors().text_color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset(
                '${icons}',
                width: 130,
                height: 110,
                color: colors().text_color,
              ),
              Text(
                '${names}',
                style: GoogleFonts.bebasNeue(
                  fontSize: 19,
                  fontWeight: FontWeight.normal,
                  color: colors().text_color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectionController());
    List<String> iconsPath = [
      'assets/images/01.png',
      'assets/images/more1.png',
      'assets/images/more2.png',
      'assets/images/more13.png',
      'assets/images/03.png',
    ];
    List<String> names = [
      'Battery',
      'Controller',
      'Motor',
      'Diagnostic',
      'Error'
    ];

    return Scaffold(
        backgroundColor: colors().backGround,
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 80),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Bounce(
                      duration: Duration(milliseconds: 170),
                      onPressed: () {
                        Get.to(() => PageBatteryView());
                      },
                      child: Card(
                        color: colors().backGround,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: colors().text_color,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Image.asset(
                                '${iconsPath[0]}',
                                width: 130,
                                height: 110,
                                color: colors().text_color,
                              ),
                              Text(
                                '${names[0]}',
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: colors().text_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Bounce(
                      duration: Duration(milliseconds: 170),
                      onPressed: () {
                        Get.to(() => PageControllerView());
                      },
                      child: Card(
                        color: colors().backGround,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: colors().text_color,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Image.asset(
                                '${iconsPath[1]}',
                                width: 130,
                                height: 110,
                                color: colors().text_color,
                              ),
                              Text(
                                '${names[1]}',
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: colors().text_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Bounce(
                        duration: Duration(milliseconds: 170),
                        onPressed: () {
                          Get.to(() => PageMotorView());
                        },
                        child: Card(
                          color: colors().backGround,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: colors().text_color,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  '${iconsPath[2]}',
                                  width: 130,
                                  height: 110,
                                  color: colors().text_color,
                                ),
                                Text(
                                  '${names[2]}',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: colors().text_color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Bounce(
                        duration: Duration(milliseconds: 170),
                        onPressed: () {
                          Get.to(() => PageVoltageView());
                        },
                        child: Card(
                          color: colors().backGround,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: colors().text_color,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  '${iconsPath[3]}',
                                  width: 130,
                                  height: 110,
                                  color: colors().text_color,
                                ),
                                Text(
                                  '${names[3]}',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: colors().text_color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Bounce(
                    duration: Duration(milliseconds: 170),
                    onPressed: () {
                      Get.to(() => PageWarningView());
                    },
                    child: Card(
                      color: colors().backGround,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: colors().text_color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Image.asset(
                              '${iconsPath[4]}',
                              width: 130,
                              height: 110,
                              color: colors().text_color,
                            ),
                            Text(
                              '${names[4]}',
                              style: GoogleFonts.bebasNeue(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
                                color: colors().text_color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
