import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/colors.dart';
import '../modules/monitor/controllers/monitor_controller.dart';

class utility {
  final controller = Get.put(MonitorController());

  disconnected_snackbar() => Get.snackbar('', '',
      padding: EdgeInsets.only(top: 12),
      backgroundColor: Color.fromARGB(255, 243, 37, 22),
      icon: Padding(
        padding: EdgeInsets.only(left: Get.width - 100),
        child: Icon(
          Icons.bluetooth_disabled,
          color: Colors.white,
        ),
      ),
      borderRadius: 200,
      duration: Duration(seconds: 3),
      messageText: Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 0),
      ),
      titleText: Text(
        'Bluetooth is turned off',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ));

  connected_snackbar() => Get.snackbar('', '',
      padding: EdgeInsets.only(
        top: 12,
      ),
      margin: EdgeInsets.only(left: 80, right: 80),
      backgroundColor: Colors.green,
      borderRadius: 200,
      duration: Duration(seconds: 3),
      messageText: Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 0),
      ),
      titleText: Text(
        'Connected!',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ));

  ble_disconnected_snackbar() => Get.snackbar('', '',
      padding: EdgeInsets.only(top: 12),
      backgroundColor: Color.fromARGB(255, 243, 166, 22),
      borderRadius: 200,
      duration: Duration(seconds: 3),
      messageText: Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 0),
      ),
      titleText: Text(
        '   Device Disconnected!',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ));

  Text heading_selections(
    String text,
  ) {
    return Text(text,
        style: GoogleFonts.bebasNeue(
          letterSpacing: 1.0,
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: colors().text_color,
        ));
  }

  Text body_selections_const(
    String text,
    Color color,
  ) {
    return Text(text,
        style: GoogleFonts.bebasNeue(
            letterSpacing: 0.0,
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: color));
  }

  maximum_value_container(RxInt val, RxInt max, String symbol) {
    if (val >= max.value) {
      max.value = val.value;
    }
    return Obx(() => Container(
        width: 120,
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
        decoration: BoxDecoration(
          color: colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text('Max  ${max.value.toString()} $symbol',
              style: GoogleFonts.bebasNeue(
                  letterSpacing: 0.0,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        )));
  }

  selection_container(
    Text text,
  ) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
      decoration: BoxDecoration(
        color: colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: text,
    );
  }
}
