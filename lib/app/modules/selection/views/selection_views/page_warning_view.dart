import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';

import '../../../../../styles/colors.dart';

class PageWarningView extends StatelessWidget {
  RxList<Map> warnings_data = [
    {
      'value': Get.find<MonitorController>().controller_power_tube_fault,
      'title': 'Controller Power Tube Fault',
      'code': 'P0001',
      'state': Get.find<MonitorController>().controller_power_tube_fault_state,
    },
    {
      'value': Get.find<MonitorController>().controller_driving_power_fault,
      'title': 'Controller Driving Power Fault',
      'code': 'P0002',
      'state':
          Get.find<MonitorController>().controller_driving_power_fault_state,
    },
    {
      'value': Get.find<MonitorController>().controller_over_current_fault,
      'title': 'Controller Over Current Fault',
      'code': 'P0003',
      'state':
          Get.find<MonitorController>().controller_over_current_fault_state,
    },
    {
      'value': Get.find<MonitorController>().controller_over_voltage_protection,
      'title': 'Controller Over Voltage Protection',
      'code': 'P0004',
      'state': Get.find<MonitorController>()
          .controller_over_voltage_protection_state,
    },
    {
      'value':
          Get.find<MonitorController>().controller_over_temprature_protection,
      'title': 'Controller Over Temperature Protection',
      'code': 'P0005',
      'state': Get.find<MonitorController>()
          .controller_over_temprature_protection_state,
    },
    {
      'value': Get.find<MonitorController>().motor_phase_wire_fault,
      'title': 'Motor Phase Wire Fault',
      'code': 'P0006',
      'state': Get.find<MonitorController>().motor_phase_wire_fault_state,
    },
    {
      'value': Get.find<MonitorController>().motor_hall_fault,
      'title': 'Motor Hall Fault',
      'code': 'P0007',
      'state': Get.find<MonitorController>().motor_hall_fault_state,
    },
    {
      'value': Get.find<MonitorController>().motor_over_temprature_protection,
      'title': 'Motor Over Temperature protection',
      'code': 'P0008',
      'state':
          Get.find<MonitorController>().motor_over_temprature_protection_state,
    },
    {
      'value':
          Get.find<MonitorController>().controller_under_voltage_protection,
      'title': 'Controller Under-Voltage protection',
      'code': 'P0009',
      'state': Get.find<MonitorController>()
          .controller_under_voltage_protection_state,
    },
    {
      'value': Get.find<MonitorController>().motor_stall_protection,
      'title': 'Motor Stall Protection',
      'code': 'P0010',
      'state': Get.find<MonitorController>().motor_stall_protection_state,
    },
    {
      'value': Get.find<MonitorController>().throttle_fault,
      'title': 'Throttle Fault',
      'code': 'P0011',
      'state': Get.find<MonitorController>().throttle_fault_state,
    },
    {
      'value': Get.find<MonitorController>().throttle_not_released,
      'title': 'Throttle not released when power-on',
      'code': 'P0012',
      'state': Get.find<MonitorController>().throttle_not_released_state,
    },
    {
      'value': Get.find<MonitorController>().bms_low_voltage,
      'title': 'BMS Low Voltage',
      'code': 'P0013',
      'state': Get.find<MonitorController>().bms_low_voltage_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_current_charge,
      'title': 'BMS Overcurrent Charge',
      'code': 'P0014',
      'state': Get.find<MonitorController>().bms_over_current_charge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_current_discharge,
      'title': 'BMS Over Current Discharge',
      'code': 'P0015',
      'state': Get.find<MonitorController>().bms_over_current_discharge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_temprature_discharge,
      'title': 'BMS Over Temperature Discharge',
      'code': 'P0016',
      'state':
          Get.find<MonitorController>().bms_over_temprature_discharge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_under_temprature_discharge,
      'title': 'BMS Under Temperature Discharge',
      'code': 'P0017',
      'state':
          Get.find<MonitorController>().bms_under_temprature_discharge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_cell_open,
      'title': 'BMS Cell Open',
      'code': 'P0018',
      'state': Get.find<MonitorController>().bms_cell_open_state,
    },
    {
      'value': Get.find<MonitorController>().bms_short_discharge,
      'title': 'BMS Short Discharge',
      'code': 'P0019',
      'state': Get.find<MonitorController>().bms_short_discharge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_temprature_charge,
      'title': 'BMS Over Temperature Charge',
      'code': 'P0020',
      'state': Get.find<MonitorController>().bms_over_temprature_charge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_under_temprature_charge,
      'title': 'BMS Under Temperature Charge',
      'code': 'P0021',
      'state': Get.find<MonitorController>().bms_under_temprature_charge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_temprature_mosfet,
      'title': 'BMS Over Temperature Mosfet',
      'code': 'P0022',
      'state': Get.find<MonitorController>().bms_over_temprature_mosfet_state,
    },
    {
      'value': Get.find<MonitorController>().bms_temprature_sensor_error,
      'title': 'BMS Temperature Sensor Error',
      'code': 'P0023',
      'state': Get.find<MonitorController>().bms_temprature_sensor_error_state,
    },
  ].obs;

  List<Container> con = [];

  List warning_titles = [
    'Controller Power Tube Fault',
    'Controller Driving Power Fault',
    'Controller Over Current Fault',
    'Controller Over Voltage Protection',
    'Controller Over Temperature Protection',
    'Motor Phase Wire Fault',
    'Motor Hall Fault',
    'Motor Over Temperature protection',
    'Controller Under-Voltage protection',
    'Motor Stall Protection',
    'Throttle Fault',
    'Throttle not released when power-on',
    'BMS Low Voltage',
    'BMS Overcurrent Charge',
    'BMS Over Current Discharge',
    'BMS Over Temperature Discharge',
    'BMS Under Temperature Discharge',
    'BMS Cell Open',
    'BMS Short Discharge',
    'BMS Over Temperature Charge',
    'BMS Under Temperature Charge',
    'BMS Over Temperature Mosfet',
    'BMS Temperature Sensor Error'
  ];
  List warning_codes = [
    'P0001',
    'P0002',
    'P0003',
    'P0004',
    'P0005',
    'P0006',
    'P0007',
    'P0008',
    'P0009',
    'P0010',
    'P0011',
    'P0012',
    'P0013',
    'P0014',
    'P0015',
    'P0016',
    'P0017',
    'P0018',
    'P0019',
    'P0020',
    'P0021',
    'P0022',
    'P0023',
  ];

  final warnings = [
    Get.find<MonitorController>().controller_power_tube_fault,
    Get.find<MonitorController>().controller_driving_power_fault,
    Get.find<MonitorController>().controller_over_current_fault,
    Get.find<MonitorController>().controller_over_voltage_protection,
    Get.find<MonitorController>().controller_over_temprature_protection,
    Get.find<MonitorController>().motor_phase_wire_fault,
    Get.find<MonitorController>().motor_hall_fault,
    Get.find<MonitorController>().motor_over_temprature_protection,
    Get.find<MonitorController>().controller_under_voltage_protection,
    Get.find<MonitorController>().motor_stall_protection,
    Get.find<MonitorController>().throttle_fault,
    Get.find<MonitorController>().throttle_not_released,
    Get.find<MonitorController>().bms_low_voltage,
    Get.find<MonitorController>().bms_over_current_charge,
    Get.find<MonitorController>().bms_over_current_discharge,
    Get.find<MonitorController>().bms_over_temprature_discharge,
    Get.find<MonitorController>().bms_under_temprature_discharge,
    Get.find<MonitorController>().bms_cell_open,
    Get.find<MonitorController>().bms_short_discharge,
    Get.find<MonitorController>().bms_over_temprature_charge,
    Get.find<MonitorController>().bms_under_temprature_charge,
    Get.find<MonitorController>().bms_over_temprature_mosfet,
    Get.find<MonitorController>().bms_temprature_sensor_error,
  ];

  error_handler_containers(RxInt x, String title, String code, RxBool state) {
    return state == true
        ? Obx(() => Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width / 2,
                    child: Text(title,
                        style: GoogleFonts.bebasNeue(
                          letterSpacing: 1.0,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: x == 1 ? Colors.red : Colors.white,
                        )),
                  ),
                  Text(code,
                      style: GoogleFonts.bebasNeue(
                        letterSpacing: 1.0,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: x == 1 ? Colors.red : Colors.white,
                      )),
                ],
              ),
            ))
        : SizedBox(
            height: 0,
          );
  }

  List<Container> containers = [];
  sorting_function() {
    warnings_data.sort((a, b) => a['value'].value.compareTo(b['value'].value));
  }

  late Stream<List<int>> warnings_stream;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
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
            ElevatedButton(
                onPressed: () {
                  Get.find<MonitorController>().change_value_true();
                },
                child: Text('FALSE')),
            ElevatedButton(
                onPressed: () {
                  Get.find<MonitorController>().change_value_true();
                },
                child: Text('TRUE')),
            ElevatedButton(
                onPressed: () {
                  for (var i = 0; i < warnings_data.length; i++) {
                    print(warnings_data[i]['state']);
                  }
                  Get.find<MonitorController>().change_value_state();
                },
                child: Text('Show Values')),
            Obx(() => SizedBox(
                  height: 500,
                  child: ListView.builder(
                      itemCount: warnings_data.length,
                      itemBuilder: (context, index) {
                        return Obx(() => error_handler_containers(
                            warnings_data[index]['value'],
                            warnings_data[index]['title'],
                            warnings_data[index]['code'],
                            warnings_data[index]['state']));
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
