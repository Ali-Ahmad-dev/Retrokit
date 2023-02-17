import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';

import '../../../../../styles/colors.dart';

class PageMotorView extends StatelessWidget {
  PageMotorView({super.key});
  final controller = Get.put(MonitorController());
  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: colors().backGround,
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: colors().backGround,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      utility().heading_selections('    Motor'),
                      Image.asset(
                        'assets/images/more2.png',
                        width: 130,
                        height: 70,
                        color: colors().text_color,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('RPM'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().speedInternal} RPM'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'revol. per minute', colors().dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().speedInternal,
                            Get.find<MonitorController>().motor_rpm_max,
                            'RPM')),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: landscape ? 0 : 15, bottom: landscape ? 0 : 15),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('ODO'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().motor_odo} KM'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'Odometer', colors().dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().motor_odo,
                            Get.find<MonitorController>().motor_odo_max,
                            'KM')),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: landscape ? 0 : 15, bottom: landscape ? 0 : 15),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('T'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().motor_temprature} °C'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'Temprature', colors().dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().motor_temprature,
                            Get.find<MonitorController>().motor_temprature_max,
                            '°C')),
                      ],
                    ),
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  controller.tier1.value = true;
                                  controller.tier2.value = false;
                                  controller.tier3.value = false;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 3,
                                        color: controller.tier1.value == true
                                            ? Colors.green
                                            : Colors.transparent),
                                  ),
                                  child: Image.asset(
                                    'assets/images/tier-1.jpg',
                                    height: 100,
                                  ),
                                ),
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  controller.tier1.value = false;
                                  controller.tier2.value = true;
                                  controller.tier3.value = false;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 3,
                                        color: controller.tier2.value == true
                                            ? Colors.green
                                            : Colors.transparent),
                                  ),
                                  child: Image.asset(
                                    'assets/images/tier-1.jpg',
                                    height: 100,
                                  ),
                                ),
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  controller.tier1.value = false;
                                  controller.tier2.value = false;
                                  controller.tier3.value = true;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 3,
                                        color: controller.tier3.value == true
                                            ? Colors.green
                                            : Colors.transparent),
                                  ),
                                  child: Image.asset(
                                    'assets/images/tier-1.jpg',
                                    height: 100,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
