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
      backgroundColor: colors().backGround,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: landscape ? 0 : 100,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('WARNING===='),
                        utility().heading_selections('45 %'),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'State of Charge', colors().dark_grey),
                        utility().selection_container(utility()
                            .body_selections_const(
                                'Max  76 %', colors().text_color))
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        utility().heading_selections('SOH'),
                        utility().heading_selections('38 %'),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'State of Health', colors().dark_grey),
                        utility().selection_container(utility()
                            .body_selections_const(
                                'Max 92 %', colors().text_color))
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
                        utility().heading_selections('T'),
                        utility().heading_selections('27°C'),
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
                        utility().selection_container(utility()
                            .body_selections_const(
                                'Max  40°C', colors().text_color))
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
                        utility().heading_selections('V'),
                        utility().heading_selections('69 V'),
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
                        utility().selection_container(utility()
                            .body_selections_const(
                                'Max  69 V', colors().text_color))
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
