import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';

import '../../../../../styles/colors.dart';

class PageWarningView extends StatelessWidget {
  const PageWarningView({super.key});

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
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: colors().backGround,
      ),
      backgroundColor: colors().backGround,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              utility().heading_selections('  Warnning'),
              Image.asset(
                'assets/images/03.png',
                width: 130,
                height: 70,
                color: colors().text_color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
