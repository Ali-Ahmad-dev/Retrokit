import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:retrokit/app/helper/bluetooth_connection.dart';
import 'package:retrokit/app/modules/splash_screen/views/splash_screen_view.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: "Application",
      // initialRoute: AppPages.INITIAL,
      // getPages: AppPages.routes,
      home: blue_connection(),
    ),
  );
}
