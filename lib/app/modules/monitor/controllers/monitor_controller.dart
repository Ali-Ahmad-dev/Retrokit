import 'dart:async';
import 'dart:io';
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/styles/colors.dart';

class MonitorController extends GetxController {
  Uuid _UART_UUID = Uuid.parse("4fafc201-1fb5-459e-8fcc-c5c9c331914b");

  //Speed internal on the circle  from BLE
  Uuid _CHARACTERISTIC_UUID_1 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a8");
  //Max Speed  From BLE
  Uuid _CHARACTERISTIC_UUID_2 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a9");
//Avg speed  From BLE
  Uuid _CHARACTERISTIC_UUID_3 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26aa");
//Tot distance  from BLE
  Uuid _CHARACTERISTIC_UUID_4 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ab");
//Range  from BLE
  Uuid _CHARACTERISTIC_UUID_5 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ac");
//ECO,  DRIVE, SPORT  from BLE
  Uuid _CHARACTERISTIC_UUID_6 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ad");
//Percentage internal to the circle  From BLE & Battery state of charge SOC
  Uuid _CHARACTERISTIC_UUID_7 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ae");
//Charging discharging current & Controller Current
  Uuid _CHARACTERISTIC_UUID_8 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26af");
//Battery state of health SOH
  Uuid _CHARACTERISTIC_UUID_10 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b0");
//Battery Temprature
  Uuid _CHARACTERISTIC_UUID_11 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b1");
//Battery Voltage
  Uuid _CHARACTERISTIC_UUID_12 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b2");
//Battery Current
  Uuid _CHARACTERISTIC_UUID_13 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b3");
//Controller Voltage
  Uuid _CHARACTERISTIC_UUID_14 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b4");
//Controller Temprature
  Uuid _CHARACTERISTIC_UUID_16 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b5");
//Controller MAPPING
  Uuid _CHARACTERISTIC_UUID_17 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ad");
//Motor RPM
  Uuid _CHARACTERISTIC_UUID_18 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a8");
//Motor Temprature
  Uuid _CHARACTERISTIC_UUID_19 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b6");
//Motor ODO
  Uuid _CHARACTERISTIC_UUID_20 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b7");
//Motor Tiers
  Uuid _CHARACTERISTIC_UUID_21 =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b8");

  final flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> foundBleUARTDevices = [];
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late Stream<ConnectionStateUpdate> _currentConnectionStream;
  late StreamSubscription<ConnectionStateUpdate> _connection;
  //Qualified characteristic according to each value
  late QualifiedCharacteristic _txCharacteristic;
  late QualifiedCharacteristic _qulaified_characteristic_1;
  late QualifiedCharacteristic _qulaified_characteristic_2;
  late QualifiedCharacteristic _qulaified_characteristic_3;
  late QualifiedCharacteristic _qulaified_characteristic_4;
  late QualifiedCharacteristic _qulaified_characteristic_5;
  late QualifiedCharacteristic _qulaified_characteristic_6;
  late QualifiedCharacteristic _qulaified_characteristic_7;
  late QualifiedCharacteristic _qulaified_characteristic_8;

  late QualifiedCharacteristic _qulaified_characteristic_10;
  late QualifiedCharacteristic _qulaified_characteristic_11;
  late QualifiedCharacteristic _qulaified_characteristic_12;
  late QualifiedCharacteristic _qulaified_characteristic_13;
  late QualifiedCharacteristic _qulaified_characteristic_14;
  late QualifiedCharacteristic _qulaified_characteristic_16;
  late QualifiedCharacteristic _qulaified_characteristic_17;
  late QualifiedCharacteristic _qulaified_characteristic_18;
  late QualifiedCharacteristic _qulaified_characteristic_19;
  late QualifiedCharacteristic _qulaified_characteristic_20;

  //Stream listening data from esp32
  late Stream<List<int>> receivedData_Stream;
  late Stream<List<int>> _speedInternal_Stream;
  late Stream<List<int>> _maxSpeed_Stream;
  late Stream<List<int>> _avgSpeed_Stream;
  late Stream<List<int>> _totalDistance_Stream;
  late Stream<List<int>> _range_Stream;
  late Stream<List<int>> _driving_mode_Stream;
  late Stream<List<int>> _percentage_internal_Stream;
  late Stream<List<int>> _current_level_Stream;
  //PAGE_BATTERY_FROM_SELECTION
  // late Stream<List<int>> _battery_state_of_charge_stream;
  late Stream<List<int>> _battery_state_of_health_stream;
  late Stream<List<int>> _battery_temprature_stream;
  late Stream<List<int>> _battery_voltage_stream;
  late Stream<List<int>> _battery_current_stream;
//CONTROLLER_FROM_SELECTION
  late Stream<List<int>> _controller_temprature_stream;
  late Stream<List<int>> _controller_voltage_stream;
  late Stream<List<int>> _controller_current_stream;
  late Stream<List<int>> _controller_mapping_stream;
  //MOTOR_FROM_SELECTION
  late Stream<List<int>> _motor_revol_stream;
  late Stream<List<int>> _motor_temprature_stream;
  late Stream<List<int>> _motor_odo_stream;

//SCANNING FROM BLE
  bool _scanning = false;
//Values from ESP
  RxBool connected = false.obs;
  bool displaying_selectDevice = false;
  bool blueON = false;
  bool disconnected_count = false;
  String _logTexts = "";
//HOME PAGE READ
  RxInt receivedData = 0.obs;
  RxInt speedInternal = 0.obs;
  RxInt maxSpeed = 0.obs;
  RxInt avgSpeed = 0.obs;
  RxInt totalDistance = 0.obs;
  RxInt range = 0.obs;
  RxInt driving_mode = 0.obs;
  RxInt percentage_internal = 0.obs;
  RxInt current_level = 0.obs;
//BATTERY PAGE 0
  RxInt battery_soh = 0.obs;
  RxInt battery_temprature = 0.obs;
  RxInt battery_voltage = 0.obs;
  RxInt battery_current = 0.obs;
//IntLLER PAGE READ
  RxInt controller_temprature = 0.obs;
  RxInt controller_voltage = 0.obs;
  RxString controller_map = ''.obs;
//MOTOR PAGE READ
  RxInt motor_rpm = 0.obs;
  RxInt motor_temprature = 0.obs;
  RxInt motor_odo = 0.obs;
  RxString motor_tier = '...'.obs;

//BATTERY MAX VALUES
  RxInt battery_soc_max = 0.obs;
  RxInt battery_soh_max = 0.obs;
  RxInt battery_temprature_max = 0.obs;
  RxInt battery_voltage_max = 0.obs;
  RxInt battery_current_max = 0.obs;
//CONTROLLER MAX VALUES
  RxInt controller_current_max = 0.obs;
  RxInt controller_temprature_max = 0.obs;
  RxInt controller_voltage_max = 0.obs;
  RxString controller_map_max = ''.obs;
//MOTOR MAX VALUES
  RxInt motor_rpm_max = 0.obs;
  RxInt motor_temprature_max = 0.obs;
  RxInt motor_odo_max = 0.obs;

  void onNewReceivedData(List<int> data) {}

  void onReceived_SpeedInternal(List<int> data) {
    speedInternal.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_maxSpeed(List<int> data) {
    maxSpeed.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_avgSpeed(List<int> data) {
    avgSpeed.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_totalDistance(List<int> data) {
    totalDistance.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_range(List<int> data) {
    range.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_percentage_internal(List<int> data) {
    percentage_internal.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_current_level(List<int> data) {
    current_level.value = int.parse("${String.fromCharCodes(data)}") - 40;
  }

  void onReceived_battery_soh(List<int> data) {
    battery_soh.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_battery_temprature(List<int> data) {
    battery_temprature.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_battery_voltage(List<int> data) {
    battery_voltage.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_battery_current(List<int> data) {
    battery_current.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_controller_voltage(List<int> data) {
    controller_voltage.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_controller_temprature(List<int> data) {
    controller_temprature.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_controller_map(List<int> data) {
    controller_map.value = "${String.fromCharCodes(data)}";
  }

  void onReceived_motor_revol(List<int> data) {
    motor_rpm.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_motor_temprature(List<int> data) {
    motor_temprature.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_motor_odo(List<int> data) {
    motor_odo.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_driving_mode(List<int> data) {
    driving_mode.value = int.parse("${String.fromCharCodes(data)}");

    driving_mode.value == 0
        ? {
            eco.value = true,
            drive.value = false,
            sport.value = false,
          }
        : driving_mode.value == 1
            ? {
                eco.value = false,
                drive.value = true,
                sport.value = false,
              }
            : driving_mode.value == 2
                ? {
                    eco.value = false,
                    drive.value = false,
                    sport.value = true,
                  }
                : {};
  }

  void _stopScan() async {
    await _scanStream.cancel();
    _scanning = false;
  }

  void startScan() async {
    bool goForIt = false;

    PermissionStatus permission;
    if (Platform.isAndroid) {
      permission = await LocationPermissions().requestPermissions();
      if (permission == PermissionStatus.granted) goForIt = true;
    } else if (Platform.isIOS) {
      goForIt = true;
    }

    if (goForIt == true) {
      foundBleUARTDevices = [];
      _scanning = true;

      _scanStream = flutterReactiveBle
          .scanForDevices(withServices: [_UART_UUID]).listen((device) {
        if (foundBleUARTDevices.every((element) => element.id != device.id)) {
          foundBleUARTDevices.add(device);
          print(device.name);

          selectDevices();
          _stopScan();
        }
      }, onError: (Object error) {
        _logTexts = "${_logTexts}ERROR while scanning:$error \n";
      });
    } else {}
  }

  onConnectDevice(int index) {
    _currentConnectionStream = flutterReactiveBle.connectToAdvertisingDevice(
      id: foundBleUARTDevices[index].id,
      prescanDuration: Duration(seconds: 1),
      withServices: [
        _UART_UUID,
        _CHARACTERISTIC_UUID_1,
        _CHARACTERISTIC_UUID_2,
        _CHARACTERISTIC_UUID_3,
        _CHARACTERISTIC_UUID_4,
        _CHARACTERISTIC_UUID_5,
        _CHARACTERISTIC_UUID_6,
        _CHARACTERISTIC_UUID_7,
        _CHARACTERISTIC_UUID_8,
        _CHARACTERISTIC_UUID_8,
        _CHARACTERISTIC_UUID_10,
        _CHARACTERISTIC_UUID_11,
        _CHARACTERISTIC_UUID_12,
        _CHARACTERISTIC_UUID_13,
        _CHARACTERISTIC_UUID_14,
        _CHARACTERISTIC_UUID_16,
        _CHARACTERISTIC_UUID_17,
        _CHARACTERISTIC_UUID_18,
        _CHARACTERISTIC_UUID_19,
        _CHARACTERISTIC_UUID_20,
        _CHARACTERISTIC_UUID_21,
      ],
    );
    print(foundBleUARTDevices[index].id);
    _logTexts = "";
    _connection = _currentConnectionStream.listen((event) {
      var id = event.deviceId.toString();
      switch (event.connectionState) {
        case DeviceConnectionState.connecting:
          {
            _logTexts = "${_logTexts}Connecting to $id\n";
            break;
          }
        case DeviceConnectionState.connected:
          {
            connected.value = true;

            _logTexts = "${_logTexts}Connected to $id\n";

            _txCharacteristic = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_6,
                deviceId: event.deviceId);
            _qulaified_characteristic_1 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_1,
                deviceId: event.deviceId);
            _qulaified_characteristic_2 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_2,
                deviceId: event.deviceId);
            _qulaified_characteristic_3 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_3,
                deviceId: event.deviceId);
            _qulaified_characteristic_4 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_4,
                deviceId: event.deviceId);
            _qulaified_characteristic_5 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_5,
                deviceId: event.deviceId);
            _qulaified_characteristic_6 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_6,
                deviceId: event.deviceId);
            _qulaified_characteristic_7 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_7,
                deviceId: event.deviceId);
            _qulaified_characteristic_8 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_8,
                deviceId: event.deviceId);
            _qulaified_characteristic_10 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_10,
                deviceId: event.deviceId);
            _qulaified_characteristic_11 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_11,
                deviceId: event.deviceId);
            _qulaified_characteristic_12 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_12,
                deviceId: event.deviceId);
            _qulaified_characteristic_13 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_13,
                deviceId: event.deviceId);
            _qulaified_characteristic_14 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_14,
                deviceId: event.deviceId);

            _qulaified_characteristic_16 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_16,
                deviceId: event.deviceId);
            _qulaified_characteristic_17 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_17,
                deviceId: event.deviceId);
            _qulaified_characteristic_18 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_18,
                deviceId: event.deviceId);
            _qulaified_characteristic_19 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_19,
                deviceId: event.deviceId);
            _qulaified_characteristic_20 = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_20,
                deviceId: event.deviceId);

            receivedData_Stream =
                flutterReactiveBle.subscribeToCharacteristic(_txCharacteristic);
            receivedData_Stream.listen((data) {
              onNewReceivedData(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _speedInternal_Stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_1);
            _speedInternal_Stream.listen((data) {
              onReceived_SpeedInternal(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _maxSpeed_Stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_2);
            _maxSpeed_Stream.listen((data) {
              onReceived_maxSpeed(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _avgSpeed_Stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_3);
            _avgSpeed_Stream.listen((data) {
              onReceived_avgSpeed(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _totalDistance_Stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_4);
            _totalDistance_Stream.listen((data) {
              onReceived_totalDistance(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _range_Stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_5);
            _range_Stream.listen((data) {
              onReceived_range(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _driving_mode_Stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_6);
            _driving_mode_Stream.listen((data) {
              onReceived_driving_mode(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _percentage_internal_Stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_7);
            _percentage_internal_Stream.listen((data) {
              onReceived_percentage_internal(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _current_level_Stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_8);
            _current_level_Stream.listen((data) {
              onReceived_current_level(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            _battery_state_of_health_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_10);
            _battery_state_of_health_stream.listen((data) {
              onReceived_battery_soh(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _battery_current_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_13);
            _battery_current_stream.listen((data) {
              onReceived_battery_current(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _battery_temprature_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_11);
            _battery_temprature_stream.listen((data) {
              onReceived_battery_temprature(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _battery_voltage_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_12);
            _battery_voltage_stream.listen((data) {
              onReceived_battery_voltage(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _controller_voltage_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_14);
            _controller_voltage_stream.listen((data) {
              onReceived_controller_voltage(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _controller_temprature_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_16);
            _controller_temprature_stream.listen((data) {
              onReceived_controller_temprature(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            _controller_mapping_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_17);
            _controller_mapping_stream.listen((data) {
              onReceived_controller_map(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _motor_revol_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_18);
            _motor_revol_stream.listen((data) {
              onReceived_motor_revol(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _motor_temprature_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_19);
            _motor_temprature_stream.listen((data) {
              onReceived_motor_temprature(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _motor_odo_stream = flutterReactiveBle
                .subscribeToCharacteristic(_qulaified_characteristic_20);
            _motor_odo_stream.listen((data) {
              onReceived_motor_odo(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            utility().connected_snackbar();
            break;
          }
        case DeviceConnectionState.disconnecting:
          {
            _logTexts = "${_logTexts}Disconnecting from $id\n";
            break;
          }
        case DeviceConnectionState.disconnected:
          {
            connected.value = false;
            _logTexts = "${_logTexts}Disconnected from $id\n";
            print(_logTexts);

            break;
          }
      }
    });
  }

  void state_organizer() async {
    var x = await flutterReactiveBle.connectedDeviceStream;
    await x.listen((event) {
      print(event.deviceId);
    });
  }

  final theme = false.obs;
  final eco = false.obs;
  final drive = true.obs;
  final sport = false.obs;

  final tier1 = true.obs;
  final tier2 = false.obs;
  final tier3 = false.obs;
  final max = 0.obs;
  @override
  void onInit() {
    super.onInit();
    startScan();
    print('====================');
    // FlutterBlue.instance.state.listen((event) {
    //   if (event.toString() == 'BluetoothState.on') {
    //     blueON = true;
    //     startScan();
    //   } else if (event.toString() == 'BluetoothState.off') {
    //     utility().ble_disconnected_snackbar();
    //     enableBT();
    //   }
    // });
  }

  Future<void> enableBT() async {
    await BluetoothEnable.enableBluetooth.then((value) {
      startScan();
      blueON = true;
    });
  }

  void theme_change() {
    if (theme.value == true) {
      theme.value = false;
    } else {
      theme.value = true;
    }
  }

  selectDevices() async {
    displaying_selectDevice = true;
    return Get.dialog(Container(
        padding: EdgeInsets.only(top: 20),
        margin:
            const EdgeInsets.only(left: 50, right: 50, top: 100, bottom: 100),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(30),
        ),
        height: 100,
        child: ListView.builder(
            itemCount: foundBleUARTDevices.length,
            itemBuilder: (context, index) => Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: index == 0 ? 70 : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 30),
                          child: Text(
                            'Select Device',
                            style: TextStyle(
                                color: colors().text_color,
                                fontSize: 18,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Retrokit',
                            style: TextStyle(
                                color: colors().text_color,
                                fontSize: 17,
                                decoration: TextDecoration.none),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              (!connected.value && _scanning) ||
                                      (!_scanning && connected.value)
                                  ? () {}
                                  : await onConnectDevice(index);

                              Get.back();
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
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: colors.green,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: colors().text_color,
                      ),
                    ],
                  ),
                ))));
  }
}

// _rxCharacteristic = QualifiedCharacteristic(
//     serviceId: _UART_UUID,
//     characteristicId: _CHARACTERISTIC_UUID_2,
//     deviceId: event.deviceId);
