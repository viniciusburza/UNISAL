import 'package:flutter/material.dart';
import 'package:lost_and_found/views/sign_in_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achados e Perdidos',
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
