//! main.dart

import 'package:flutter/material.dart';
import 'package:marcador_de_truco/views/home_page.dart';
import 'package:screen/screen.dart';


void main() {
  Screen.keepOn(true);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.red, brightness: Brightness.dark),
    home: HomePage(),
  ));
}

