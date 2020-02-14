import 'package:flutter/material.dart';
//import 'package:ble/auth/login.dart';
import 'package:ble/index.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        highlightColor: Colors.green,
      ),
      home: IndexPage(),
    );
  }
}