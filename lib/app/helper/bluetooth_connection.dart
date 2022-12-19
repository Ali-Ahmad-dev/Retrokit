import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class blue_connection extends StatefulWidget {
  const blue_connection({super.key});

  @override
  State<blue_connection> createState() => _blue_connectionState();
}

class _blue_connectionState extends State<blue_connection> {
  Future<void> _discovery() async {
    print('Devices are scanned');
    final blueInstance = await FlutterBlue.instance;
    setState(() {
      final connected = blueInstance.connectedDevices;
      print(connected);
      connected.asStream().listen((event) {
        event.forEach((element) {
          print(element.name);
        });
      });
    });
  }

  flutter_ble(BluetoothCharacteristic characteristic) {
    var char = characteristic.read();
  }

  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);

  Future<void> _startDiscovery() async {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        final existingIndex = results.indexWhere(
            (element) => element.device.address == r.device.address);
        if (existingIndex >= 0)
          results[existingIndex] = r;
        else
          results.add(r);
      });
    });

    _streamSubscription!.onDone(() {
      setState(() {});
    });
    final bondedDevices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    final dev = bondedDevices.where((element) => element.isConnected);

    print(dev.first.name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _discovery();
    // _startDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(itemBuilder: (BuildContext, index) {
          // BluetoothDiscoveryResult result = results[index];
          // final device = result.device;
          // final name = device.name;
          // final address = device.type;
          return Card(
            child: Column(
              children: [
                //  Text('$'),
              ],
            ),
          );
        }),
      ),
    );
  }
}
