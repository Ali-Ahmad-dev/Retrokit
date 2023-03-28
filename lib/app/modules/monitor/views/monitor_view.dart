import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:retrokit/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
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
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            fontFamily: 'BebasNeue',
            color: colors().text_color,
          ));
    }

    Text headingTextWidget(String text, double fontSize, Color fontColor) {
      return Text(text,
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: fontSize,
            fontFamily: 'BebasNeue',
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
            ? EdgeInsets.only(left: 10, right: 10, top: 0)
            : EdgeInsets.all(0),
        child: SafeArea(
          child: Flex(
            direction: landscape ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              landscape == false
                  ? Align(
                      alignment: landscape
                          ? Alignment.bottomRight
                          : Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(() => controller.connected.value == false
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (controller.blueON == false) {
                                      controller.enableBT();
                                    } else if (controller.connected.value ==
                                            false &&
                                        controller.blueON == true) {
                                      controller.startScan();
                                    }
                                  },
                                  child: Text(
                                    'Connect',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    backgroundColor: colors.green,
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                controller.logout();
                              },
                              child: Icon(Icons.login_outlined,
                                  color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(10),
                                backgroundColor: Color.fromARGB(
                                    255, 233, 210, 7), // <-- Button color
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(''),
              Flexible(flex: 0, child: Obx(() => containerWidget())),
              Flexible(
                flex: 1,
                child: Stack(alignment: Alignment.center, children: [
                  Obx(() => Transform.scale(
                        scaleX:
                            controller.current_level.value.isNegative ? -1 : 1,
                        child: GFProgressBar(
                          percentage: controller.current_level.value >= 80
                              ? 1.0
                              : controller.current_level.value <= -40
                                  ? 1.0
                                  : controller.current_level.value.isNegative
                                      ? controller.current_level.value.abs() *
                                          2.5 /
                                          100
                                      : controller.current_level.value *
                                          1.25 /
                                          100,
                          progressHeadType: GFProgressHeadType.circular,
                          radius: landscape ? Get.height - 75 : Get.width - 50,
                          circleWidth: 11,
                          type: GFProgressType.circular,
                          backgroundColor: Colors.grey,
                          progressBarColor:
                              controller.current_level.value.isNegative
                                  ? Colors.blue
                                  : colors.green,
                        ),
                      )),
                  Image.asset(
                    'assets/images/FulmineIcon-e.png',
                    height: 220,
                    width: 120,
                    color: colors().grey,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: landscape ? Get.width / 6 : Get.width / 3,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: landscape ? 60 : 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                Obx(
                                  () => RotatedBox(
                                    quarterTurns: -1,
                                    child: Container(
                                      width: 58,
                                      height: 37,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        child: LinearProgressIndicator(
                                          value: controller
                                                  .percentage_internal.value /
                                              100,
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Color.fromARGB(255, 16, 232, 27)),
                                          backgroundColor: colors().backGround,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/battery-charging.png',
                                  width: 60,
                                  color: colors().text_color,
                                ),
                              ]),
                              Obx(() => Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${controller.percentage_internal} %',
                                      style: TextStyle(
                                          fontFamily: 'BebasNeue',
                                          fontSize: 23,
                                          color: Colors.green),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Obx(
                          () => SizedBox(
                            width: landscape
                                ? Get.width / 6 + 30
                                : Get.width / 3 + 25,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  controller.tier1 == true
                                      ? '${controller.speedInternal.value}'
                                      : controller.tier2 == true
                                          ? '${controller.speedInternal.value}'
                                          : controller.tier3 == true
                                              ? '${controller.speedInternal.value}'
                                              : '${controller.speedInternal.value}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontFamily: 'BebasNeue',
                                    fontSize:
                                        controller.speedInternal.value >= 100
                                            ? 110
                                            : 170,
                                    letterSpacing: -3,
                                    color: colors().text_color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:
                            landscape ? Get.width / 6 - 12 : Get.width / 3 - 25,
                        child: SizedBox(
                          height: 45,
                          width: 55,
                          child: Text(
                            'Km/h',
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              letterSpacing: 0,
                              fontSize: 30,
                              color: colors().text_color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Obx(() => Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        direction: landscape ? Axis.vertical : Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: InkWell(
                              onTap: () {
                                final Uri _url =
                                    Uri.parse('https://retrokit.it/');
                                launchUrl(_url);
                              },
                              child: Image.asset(
                                'assets/images/retrokit_golden.png',
                                width: 100,
                                color: Color.fromARGB(
                                  255,
                                  242,
                                  201,
                                  25,
                                ),
                              ),
                            ),
                          ),
                          Flex(
                            direction: Axis.vertical,
                            children: [
                              Container(
                                width: 110,
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
                                child: Center(
                                    child: textWidget(
                                        'ECO', 25, colors().text_color)),
                              ),
                              Container(
                                width: 110,
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
                                child: Center(
                                  child: textWidget(
                                      'DRIVE', 25, colors().text_color),
                                ),
                              ),
                              Container(
                                width: 110,
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
                                child: Center(
                                  child: textWidget(
                                      'Sport', 25, colors().text_color),
                                ),
                              ),
                            ],
                          ),
                          landscape == true
                              ? Row(
                                  children: [
                                    Align(
                                      alignment: landscape
                                          ? Alignment.bottomRight
                                          : Alignment.topRight,
                                      child: Obx(() => controller
                                                  .connected.value ==
                                              false
                                          ? ElevatedButton(
                                              onPressed: () {
                                                if (controller.blueON ==
                                                    false) {
                                                  controller.enableBT();
                                                } else if (controller
                                                            .connected.value ==
                                                        false &&
                                                    controller.blueON == true) {
                                                  controller.startScan();
                                                }
                                              },
                                              child: Text(
                                                'Connect',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                backgroundColor: colors.green,
                                              ),
                                            )
                                          : SizedBox(
                                              height: 0,
                                            )),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.logout();
                                      },
                                      child: Icon(Icons.login_outlined,
                                          color: Colors.white),
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Color.fromARGB(255,
                                            233, 210, 7), // <-- Button color
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(
                                  width: 100,
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
