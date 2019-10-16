import 'package:flutter/material.dart';
import 'package:lost_and_found/views/about_page.dart';
import 'package:lost_and_found/views/found_page.dart';
import 'package:lost_and_found/views/home_page.dart';
import 'package:lost_and_found/views/profile_page.dart';
import 'package:lost_and_found/views/root_page.dart';
import 'package:lost_and_found/views/sign_in_page.dart';
import 'package:lost_and_found/views/sign_up_page.dart';
import 'package:lost_and_found/views/use_term_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achados e Perdidos',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        SignInPage.routeName: (BuildContext context) => new SignInPage(),
        SignUpPage.routeName: (BuildContext context) => new SignUpPage(),
        HomePage.routeName: (BuildContext context) => new HomePage(),
        AboutPage.routeName: (BuildContext context) => new AboutPage(),
        FoundPage.routeName: (BuildContext context) => new FoundPage(),
        ProfilePage.routeName: (BuildContext context) => new ProfilePage(),
        UseTermPage.routeName: (BuildContext context) => new UseTermPage(),
      },
      home: RootPage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
