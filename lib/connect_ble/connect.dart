import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';


class BLEView extends StatefulWidget {
  @override
  _BLEViewState createState() => _BLEViewState();
}

class _BLEViewState extends State<BLEView> {
  // default device
  final String SERVICE_UUID = "a4544750-0c15-4dc2-9b75-fa34cfd5e93d";
  final String CHARACTERISTIC_UUID = "7aa5a50c-8543-484f-b52e-b8ffce0d8cfb";
  final String TARGET_DEVICE_NAME = "test_led";

  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription<ScanResult> scanSubScription;

  BluetoothDevice targetDevice;
  BluetoothCharacteristic targetCharacteristic;

  List<BluetoothDevice> devices = [];

  String connectionText = "";


  @override
  void initState() {
    super.initState();
    startScan();
  }

  startScan() {
    setState(() {
      connectionText = "Start Scanning";
    });

    scanSubScription = flutterBlue.scan().listen((scanResult) {
      devices.add(scanResult.device);
    }, onDone: () => (){
      stopScan();
    });
  }

  stopScan() {
    scanSubScription?.cancel();
    scanSubScription = null;
  }

  connectToDevice() async {
    if (targetDevice == null) return;
    setState(() {
      connectionText = "Device Connecting";
    });

    await targetDevice.connect();

    setState(() {
      connectionText = "Device Connected";
    });

    discoverServices();
  }

  disconnectFromDevice() {
    if (targetDevice == null) return;
    targetDevice.disconnect();
    setState(() {
      connectionText = "Device Disconnected";
    });
  }


  discoverServices() async {
    if (targetDevice == null) return;
    List<BluetoothService> services = await targetDevice.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            targetCharacteristic = characteristic;
            writeData("Hi there, Welcome");
            setState(() {
              connectionText = "All Ready with ${targetDevice.name}";
            });
          }
        });
      }
    });
  }

  writeData(String data) {
    if (targetCharacteristic == null) return;

    List<int> bytes = utf8.encode(data);
    targetCharacteristic.write(bytes);
  }

  @override
  Widget build(BuildContext context) {
    String data = "";

    void sendFValue(){
      data = "F";
      setState(() {
        connectionText = "send command F";
      });
      writeData(data);
    }
    void sendOValue(){
      data = "O";
      setState(() {
        connectionText = "send command O";
      });
      writeData(data);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(connectionText),
      ),
      body: Container(
        child: targetCharacteristic == null
            ? Center(
          child: Text(
            "Waiting...",
            style: TextStyle(fontSize: 24, color: Colors.red),
          ),
        )
            : Column(
          children: <Widget>[
            SizedBox(height: 100,),
            RaisedButton(
              onPressed:sendFValue,
              child: Text("OFF"),
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.black,
              highlightColor: Colors.green,
            ),
            SizedBox(height: 100,),
            RaisedButton(
              onPressed:sendOValue,
              child: Text("ON"),
              color: Colors.blueAccent,
              textColor: Colors.white,
              splashColor: Colors.black,
              highlightColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}