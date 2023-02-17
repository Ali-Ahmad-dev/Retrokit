import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/styles/colors.dart';
import '../controllers/monitor_controller.dart';

class MonitorView extends GetView<MonitorController> {
  MonitorView({Key? key}) : super(key: key);

  final controller = Get.put(
    MonitorController(),
  );

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Text textWidget(String text, double fontSize, Color fontColor) {
      return Text(text,
          style: GoogleFonts.bebasNeue(
            letterSpacing: 1.0,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: colors().text_color,
          ));
    }

    Text headingTextWidget(String text, double fontSize, Color fontColor) {
      return Text(text,
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: colors().text_color,
          ));
    }

    List<String> headings = const [
      'Max speed',
      'Avg speed',
      'Tot distance',
      'Range'
    ];

    List<RxInt> values = [
      controller.maxSpeed,
      controller.avgSpeed,
      controller.totalDistance,
      controller.range,
    ];
    List<String> units = const ['km/h', 'km/h', 'km', 'km'];

    containerWidget() {
      List<Container> _containers = [];
      for (var i = 0; i < headings.length; i++) {
        _containers.add(Container(
          width: landscape ? Get.width / 4 - 20 : Get.width / 2 - 15,
          padding: EdgeInsets.only(
            top: landscape ? 2 : 4,
            bottom: landscape ? 4 : 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 1.5, color: colors().text_color),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 5),
                  child: headingTextWidget(
                      headings[i], landscape ? 12 : 14, colors().text_color)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(values[i].value.toString(), landscape ? 24 : 27,
                      colors().text_color),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: textWidget(
                        units[i], landscape ? 11 : 14, colors().text_color),
                  ),
                ],
              )
            ],
          ),
        ));
      }
      return landscape
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _containers[0],
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: _containers[1],
                ),
                _containers[2],
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: _containers[3],
                ),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        _containers[0],
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _containers[1],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _containers[2],
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: _containers[3],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
    }

    return Scaffold(
      backgroundColor: colors().backGround,
      body: Padding(
        padding: landscape
            ? EdgeInsets.only(left: 10, right: 10, top: 10)
            : EdgeInsets.all(0),
        child: SafeArea(
          child: Flex(
            direction: landscape ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Obx(() => Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: controller.connected.value == false
                          ? ElevatedButton(
                              onPressed: () {
                                // if (controller.blueON == false) {
                                //   controller.enableBT();
                                // } else if (controller.connected.value ==
                                //         false &&
                                //     controller.blueON == true) {
                                controller.onConnectDevice(0);
                                // }
                              },
                              child: Text(
                                'Connect',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    decoration: TextDecoration.none),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: colors.green,
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                    )),
              ),
              Flexible(flex: 0, child: Obx(() => containerWidget())),
              Flexible(
                flex: 1,
                child: Stack(alignment: Alignment.center, children: [
                  Obx(() => GFProgressBar(
                        percentage: controller.speedInternal.value / 100,
                        progressHeadType: GFProgressHeadType.circular,
                        radius: landscape ? Get.height - 75 : Get.width - 50,
                        circleWidth: 11,
                        type: GFProgressType.circular,
                        backgroundColor: Colors.grey,
                        progressBarColor: colors.green,
                      )),
                  Image.asset(
                    'assets/images/FulmineIcon-e.png',
                    height: 220,
                    width: 120,
                    color: colors().grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: landscape ? Get.height / 4 - 20 : 45,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => RotatedBox(
                                  quarterTurns: -1,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    width: 45,
                                    height: 30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      child: LinearProgressIndicator(
                                        value: controller.current_level.value *
                                            1.25 /
                                            100,
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Color.fromARGB(255, 28, 197, 249)),
                                        backgroundColor: colors().grey,
                                      ),
                                    ),
                                  ),
                                )),
                            Obx(() => RotatedBox(
                                  quarterTurns: -3,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    width: 45,
                                    height: 30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      child: LinearProgressIndicator(
                                        value: controller
                                                .current_level.value.isNegative
                                            ? controller.current_level.value
                                                    .abs() *
                                                2.5 /
                                                100
                                            : 0,
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Color.fromARGB(255, 5, 183, 23)),
                                        backgroundColor: colors().grey,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Obx(() => Padding(
                            padding: EdgeInsets.only(right: landscape ? 0 : 10),
                            child: SizedBox(
                              height: landscape ? 230 : 260,
                              width: landscape
                                  ? controller.speedInternal.value <= 9
                                      ? 45
                                      : 90
                                  : controller.speedInternal.value <= 9
                                      ? 53
                                      : 106,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  controller.tier1 == true
                                      ? '${controller.speedInternal.value * 10}'
                                      : controller.tier2 == true
                                          ? '${controller.speedInternal.value * 20}'
                                          : '${controller.speedInternal.value * 30}',
                                  style: GoogleFonts.bebasNeue(
                                    letterSpacing: -3.0,
                                    fontSize: 160,
                                    fontWeight: FontWeight.normal,
                                    color: colors().text_color,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            right: landscape ? Get.height / 4 : 55),
                        child: SizedBox(
                          height: 45,
                          width: 55,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              'Km/h',
                              style: TextStyle(
                                letterSpacing: 0.0,
                                fontFamily: 'Graphik',
                                // fontSize: 29,
                                fontWeight: FontWeight.w600,
                                color: colors().text_color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: landscape ? 220 : 220, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                              controller.percentage_internal.value.toString(),
                              style: GoogleFonts.bebasNeue(
                                letterSpacing: -1.0,
                                fontSize: 35,
                                fontWeight: FontWeight.normal,
                                color: colors.green,
                              ),
                            )),
                        Text(
                          '%',
                          style: GoogleFonts.bebasNeue(
                            letterSpacing: -1.0,
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: colors.green,
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              Obx(() => Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        direction: landscape ? Axis.vertical : Axis.horizontal,
                        children: [
                          Image.asset(
                            'assets/images/retrokit_golden.png',
                            width: 100,
                            color: Color.fromARGB(
                              255,
                              242,
                              201,
                              25,
                            ),
                          ),
                          Flex(
                            direction: Axis.vertical,
                            children: [
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {},
                                child: Container(
                                  width: 130,
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        width: 2,
                                        color: controller.eco.value == true
                                            ? colors().text_color
                                            : Colors.transparent),
                                  ),
                                  child: textWidget(
                                      'ECO', 25, colors().text_color),
                                ),
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {},
                                child: Container(
                                  width: 130,
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        width: 2,
                                        color: controller.drive.value == true
                                            ? colors().text_color
                                            : Colors.transparent),
                                  ),
                                  child: textWidget(
                                      'DRIVE', 25, colors().text_color),
                                ),
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {},
                                child: Container(
                                  width: 130,
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        width: 2,
                                        color: controller.sport.value == true
                                            ? colors().text_color
                                            : Colors.transparent),
                                  ),
                                  child: textWidget(
                                      'Sport', 25, colors().text_color),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.light_mode_outlined,
                              size: MediaQuery.of(context).orientation ==
                                      Orientation.landscape
                                  ? 30
                                  : 40,
                              color: controller.theme == true
                                  ? Colors.amber
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
