import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_local_apii/assets/themes.dart';
import 'package:latihan_local_apii/views/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: myTheme,
      home: HomePage(), 
    );
  }
}
