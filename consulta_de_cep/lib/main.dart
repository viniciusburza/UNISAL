import 'package:flutter/material.dart';
import 'Views/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: TextTheme(title: TextStyle(color: Colors.black))),
  ));
}

