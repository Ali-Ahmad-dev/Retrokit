import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';

import '../../../../../styles/colors.dart';

class PageControllerView extends StatelessWidget {
  const PageControllerView({super.key});

  Text textWidget(String text, double fontSize, Color fontColor) {
    return Text(text,
        style: GoogleFonts.bebasNeue(
          letterSpacing: 1.0,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: colors().text_color,
        ));
  }

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
                      utility().heading_selections('  Controller'),
                      Image.asset(
                        'assets/images/more1.png',
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
                        utility().heading_selections('V'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().controller_voltage} V'),
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
                            'Voltage', colors().dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().controller_voltage,
                            Get.find<MonitorController>()
                                .controller_voltage_max,
                            'V')),
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
                        utility().heading_selections('I'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().current_level} A'),
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
                            'Current', colors().dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().current_level,
                            Get.find<MonitorController>()
                                .controller_current_max,
                            ' A')),
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
                              '${Get.find<MonitorController>().controller_temprature} °C'),
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
                            Get.find<MonitorController>().controller_temprature,
                            Get.find<MonitorController>()
                                .controller_temprature_max,
                            '°C')),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscape ? 0 : 15, bottom: landscape ? 0 : 15),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('MAP'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().driving_mode}'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'mapping', colors().dark_grey),
                      ],
                    ),
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