import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';

class colors {
  // final put = Get.put(MonitorController());
  Color backGround =
      // Get.find<MonitorController>().theme == true ? Colors.white :
      Colors.black;
  Color text_color =
      //  Get.find<MonitorController>().theme == false
      //     ?
      Colors.white;
  // : Colors.black;
  Color grey =
      //  Get.find<MonitorController>().theme == true
      //     ? Colors.grey.shade400
      //     :
      Colors.grey.shade800;
  Color black_shade =
      // Get.find<MonitorController>().theme == true
      //     ? Colors.white70
      //     :
      Colors.grey.shade800;

  static const green = Colors.green;
  static const red = Colors.red;

  var dark_grey = Colors.grey.shade700;
}
