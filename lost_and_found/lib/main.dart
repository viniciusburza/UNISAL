import 'package:flutter/material.dart';
import 'package:lost_and_found/views/found_object_detail_page.dart';
import 'package:splashscreen/splashscreen.dart';
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
        FoundObjectDetailPage.routeName: (BuildContext context) =>
            new FoundObjectDetailPage(),
      },
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          navigateAfterSeconds: RootPage(),
          backgroundColor: Colors.white,
          gradientBackground: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/logo.png"),
            ),
          ),
        ),
      ],
    );
  }
}
