import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';
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
    return InkWell(
      onTap: () {
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
                style: TextStyle(
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
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: colors().backGround,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  Get.find<MonitorController>().logout();
                },
                child: Row(
                  children: [
                    Text(
                      ' Logout ',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Icon(Icons.login_outlined),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.only(right: 10, left: 10),
                  backgroundColor:
                      Color.fromARGB(255, 233, 210, 7), // <-- Button color
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
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
                                style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: 'BebasNeue',
                                  fontWeight: FontWeight.normal,
                                  color: colors().text_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
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
                                style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: 'BebasNeue',
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
                      InkWell(
                        onTap: () {
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
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'BebasNeue',
                                    color: colors().text_color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'BebasNeue',
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
                  child: InkWell(
                    onTap: () {
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
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BebasNeue',
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
