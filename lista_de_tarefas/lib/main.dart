import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/views/home_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.lightBlue)));
}
